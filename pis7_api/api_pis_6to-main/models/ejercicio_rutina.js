'use strict';
const { UUIDV4 } = require("sequelize");
module.exports = (sequelize, DataTypes) => {
    const ejercicio_rutina = sequelize.define('ejercicio_rutina', {
        external_id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    }, {
        freezeTableName: true
    });

    ejercicio_rutina.associate = function (models){
        ejercicio_rutina.belongsTo(models.ejercicio, {foreignKey: 'id_ejercicio'});
        ejercicio_rutina.belongsTo(models.rutina, {foreignKey: 'id_rutina'});
    }
    return ejercicio_rutina;
};
