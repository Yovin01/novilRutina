'use strict';
const { UUIDV4 } = require("sequelize");
module.exports = (sequelize, DataTypes) => {
    const rutina_ejercicio = sequelize.define('rutina_ejercicio', {
        external_id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    }, {
        freezeTableName: true
    });

    rutina_ejercicio.associate = function (models){
        rutina_ejercicio.belongsTo(models.rutina, {foreignKey: 'id_rutina_ejercicio'});
        rutina_ejercicio.belongsTo(models.ejercicio, {foreignKey: 'id_ejercicio'});
   }
    return rutina_ejercicio;
};
