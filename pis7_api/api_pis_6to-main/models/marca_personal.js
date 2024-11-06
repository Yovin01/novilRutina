'use strict';
module.exports = (sequelize, DataTypes) => {
    const marca_personal = sequelize.define('marca_personal', {
        repeticiones: { type: DataTypes.INTEGER, allowNull: false },
        external_id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    }, {
        freezeTableName: true
    });
    marca_personal.associate = function (models) {
        marca_personal.belongsTo(models.ejercicio, { foreignKey: 'id_ejercicio' });
        marca_personal.belongsTo(models.sujeto, { foreignKey: 'id_sujeto' });
        marca_personal.belongsTo(models.unidad, {foreignKey: 'id_unidad'});
    }
    return marca_personal;
};
