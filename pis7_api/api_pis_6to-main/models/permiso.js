'use strict';

module.exports = (sequelize, DataTypes) => {
    const permiso = sequelize.define('permiso', {
        nombre: {type: DataTypes.STRING(20), unique:true },
        estado: {type: DataTypes.BOOLEAN, defaultValue: true},
        external_id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    }, {freezeTableName: true});

    permiso.associate = function (models) {
        permiso.hasMany(models.sujeto_rol, {foreignKey: 'id_permiso', as: 'sujeto_rol'});
    }

    return permiso;    
};
