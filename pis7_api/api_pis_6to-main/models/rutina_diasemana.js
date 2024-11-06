'use strict';
const { UUIDV4 } = require("sequelize");
module.exports = (sequelize, DataTypes) => {
    const rutina_diasemana = sequelize.define('rutina_diasemana', {
        external_id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    }, {
        freezeTableName: true
    });

    rutina_diasemana.associate = function (models){
        rutina_diasemana.belongsTo(models.dias_semana, {foreignKey: 'id_dias_semana'});
        rutina_diasemana.belongsTo(models.rutina, {foreignKey: 'id_rutina'});
    }
    return rutina_diasemana;
};
