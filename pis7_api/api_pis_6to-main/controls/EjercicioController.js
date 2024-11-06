'use strict';
var models = require('../models');
class EjercicioController {

    async getEjercicioPGM(req, res) {
        try {
            const lista = await models.ejercicio.findAll({ where: { id_grupo_muscular: req.params.id_grupo_muscular },attributes: ['id', 'nombre', 'external_id', 'id_grupo_muscular'] });
            if (!lista) {
                return res.status(404).json({ msg: "Ejercicio no encontrado", code: 404 });
            }
            res.json({ msg: "Ejercicios encontrados", code: 200, info: lista });
        } catch (error) {
            console.error(error);
            res.status(500).json({ msg: "Error al obtener grupos musculares", code: 500 });
        }
    }
    
}

module.exports = EjercicioController;
