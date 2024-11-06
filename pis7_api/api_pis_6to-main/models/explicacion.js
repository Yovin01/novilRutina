'use strict';
module.exports = (sequelize, DataTypes) => {
    const explicacion = sequelize.define('explicacion', {
        descripcion: { type: DataTypes.STRING(100), allowNull: true },
        external_id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    }, {
        freezeTableName: true
    });
    explicacion.associate = function (models) {
        explicacion.belongsTo(models.ejercicio, { foreignKey: 'id_ejercicio' });
    }
    return explicacion;
};
