'use strict';
var models = require('../models');
const uuid = require('uuid');

class GrupoMuscularController {

    async getGruposMusculares(req, res) {
        try {
            const lista = await models.grupo_muscular.findAll({ attributes: ['id', 'nombre', 'external_id', 'descripcion'] });
            if (!lista) {
                return res.status(404).json({ msg: "Sujeto no encontrado", code: 404 });
            }
            res.json({ msg: "Grupos musculares encontradas", code: 200, info: lista });
        } catch (error) {
            console.error(error);
            res.status(500).json({ msg: "Error al obtener grupos musculares", code: 500 });
        }
    }
    
}

module.exports = GrupoMuscularController;
