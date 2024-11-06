'use strict';
module.exports = (sequelize, DataTypes) => {
    const cuenta = sequelize.define('cuenta', {
        correo: { type: DataTypes.STRING(60), allowNull: false, unique:true },
        clave: { type: DataTypes.STRING(250), allowNull: false },
        external_id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
        estado: {type: DataTypes.BOOLEAN, defaultValue: true},
        //token: { type: DataTypes.STRING(250), allowNull: false }
    }, {
        freezeTableName: true
    });

    cuenta.associate = function (models){
        cuenta.belongsTo(models.sujeto, {foreignKey: 'id_sujeto'});
        cuenta.belongsTo(models.rol, {foreignKey: 'id_rol'});
        cuenta.belongsTo(models.imagen, {foreignKey: 'id_imagen'});
        cuenta.hasMany(models.mensaje, {foreignKey: 'id_cuenta', as: 'mensaje'});
    }
    return cuenta;
};
