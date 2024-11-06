'use strict';
module.exports = (sequelize, DataTypes) => {
    const cantidad = sequelize.define('cantidad', {
        external_id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
        cantidad: { type: DataTypes.FLOAT,  allowNull: false },   }, {
        freezeTableName: true
    });

    cantidad.associate = function (models){
        cantidad.belongsTo(models.unidad, {foreignKey: 'id_unidad'});
        cantidad.hasOne(models.sujeto, { foreignKey: 'id_cantidad', as: 'peso'});
        cantidad.hasOne(models.sujeto, { foreignKey: 'id_cantidad', as: 'altura'});
    }
    return cantidad;
};  