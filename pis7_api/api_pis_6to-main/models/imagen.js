'use strict';
module.exports = (sequelize, DataTypes) => {
    const imagen = sequelize.define('imagen', {
        external_id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
        documentacion: { type: DataTypes.STRING(70), allowNull: true },
    }, {
        freezeTableName: true
    });
    imagen.associate = function (models) {
        imagen.hasOne(models.ejercicio, { foreignKey: 'id_imagen', as: 'imagen_ejercicio' });
        imagen.hasOne(models.cuenta, { foreignKey: 'id_imagen', as: 'imagen_cuenta' });
    }
    return imagen;
};
