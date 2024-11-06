'use strict';
var models = require('../models');
const uuid = require('uuid');

class RutinaController {

    async getRutinas(req, res) {
        try {
            const sujeto = await models.sujeto.findOne({ where: { external_id: req.params.id }, attributes: ['id'] });
            if (!sujeto) {
                return res.status(404).json({ msg: "Sujeto no encontrado", code: 404 });
            }

            const rutinas = await models.rutina.findAll({ where: { id_sujeto: sujeto.id }, attributes: ['id', 'nombre', 'descripcion', 'external_id'] });

            const rutinaConDias = await Promise.all(rutinas.map(async (rutina) => {
                const dias = await models.rutina_diasemana.findAll({
                    where: { id_rutina: rutina.id },
                    attributes: ['id_dias_semana']
                });
                const diasSemana = dias.map(d => d.id_dias_semana);
                return {
                    ...rutina.get({ plain: true }),
                    diasSemana
                };
            }));

            console.log(rutinaConDias);
            res.json({ msg: "Rutinas encontradas", code: 200, info: rutinaConDias });
        } catch (error) {
            console.error(error);
            res.status(500).json({ msg: "Error al obtener rutinas", code: 500 });
        }
    }


    async guardar(req, res) {
        let transaction;
        try {
            transaction = await models.sequelize.transaction();
            const rutina = await models.rutina.findOne({ where: { nombre: req.body.nombre } });
            const sujeto = await models.sujeto.findOne({ where: { external_id: req.body.id_sujeto } });
            if (sujeto === null) {
                res.json({ msg: "El sujeto no existe", });
            } else {
                if (rutina === null) {
                    const data = {
                        nombre: req.body.nombre,
                        id_sujeto: sujeto.id,
                        external_id: uuid.v4(),
                        descripcion: req.body.descripcion
                    }
                    const nuevaRutina = await models.rutina.create(data, { transaction });
                    const diasSemana = req.body.diasemana.split(';').map(dia => parseInt(dia, 10));
                    // Asociar los días a la rutina
                    for (const dia of diasSemana) {
                        await models.rutina_diasemana.create({ id_rutina: nuevaRutina.id, id_dias_semana: dia }, { transaction });
                    }
                    await transaction.commit();
                    res.json({ msg: "SE HA REGISTRADO CORRECTAMENTE", code: 200, info: data.external_id });
                } else {
                    res.json({ msg: "La rutina ya existe", code: 200 });
                }
            }
        } catch (error) {
            if (transaction) await transaction.rollback();
            if (error.errors && error.errors[0].message) {
                res.json({ msg: error.errors[0].message, code: 200 });
            } else { res.json({ msg: error.message, code: 200 }); }
        }
    }

    async agregarEjercicio(req, res) {
        let transaction;    
        try {
            transaction = await models.sequelize.transaction();
            const rutina = await models.rutina.findOne({ where: { external_id: req.body.external_id } });
            console.log(rutina);
            console.log(req.body);
            if (!rutina) {
                return res.status(404).json({ msg: "Rutina no encontrada", code: 404 });
            }
            const idEjercicios = req.body.ejercicios.split(';').map(ejercicio => parseInt(ejercicio, 10));
            for (const ejercicio of idEjercicios) {
                await models.rutina_ejercicio.create({ id_rutina: rutina.id, id_ejercicio: ejercicio }, { transaction });
            }
            await transaction.commit();
            res.json({ msg: "SE HA REGISTRADO CORRECTAMENTE", code: 200 });
        } catch (error) {
            console.error(error);
            res.status(500).json({ msg: "Error al agregar ejercicio a la rutina", code: 500 });
        }
    }

}

module.exports = RutinaController;
