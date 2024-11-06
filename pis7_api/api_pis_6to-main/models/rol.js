'use strict';

module.exports = (sequelize, DataTypes) => {
    const rol = sequelize.define('rol', {
        nombre: {type: DataTypes.STRING(20), unique:true },
        estado: {type: DataTypes.BOOLEAN, defaultValue: true},
        external_id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    }, {freezeTableName: true});

    rol.associate = function (models) {
        rol.hasMany(models.sujeto_rol, {foreignKey: 'id_rol', as: 'sujeto_rol'});
    }

    return rol;    
};