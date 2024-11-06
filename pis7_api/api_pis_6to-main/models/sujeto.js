'use strict';
module.exports = (sequelize, DataTypes) => {
    const sujeto = sequelize.define('sujeto', {
        nombres: { type: DataTypes.STRING(70), defaultValue: "NO_DATA" },
        apellidos: { type: DataTypes.STRING(70), defaultValue: "NO_DATA" },
        external_id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4},
        fecha_nacimiento:{type: DataTypes.DATE},
        estado:{type: DataTypes.BOOLEAN, defaultValue: true}
    }, {
        freezeTableName: true
    });
    sujeto.associate = function (models){
        sujeto.hasOne(models.cuenta, { foreignKey: 'id_sujeto', as: 'cuenta'});
       sujeto.hasMany(models.sujeto_rol, {foreignKey: 'id_sujeto', as: 'sujeto_rol'});
       sujeto.belongsTo(models.cantidad, { foreignKey: 'id_cantidad', as: 'peso'});
       sujeto.belongsTo(models.cantidad, { foreignKey: 'id_cantidad', as: 'altura'});

    }
    return sujeto;
};