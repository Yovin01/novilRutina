'use strict';
module.exports = (sequelize, DataTypes) => {
    const sujeto_rol = sequelize.define('sujeto_rol', {
        external_id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    }, {
        freezeTableName: true
    });

    sujeto_rol.associate = function (models){
        sujeto_rol.belongsTo(models.sujeto, {foreignKey: 'id_sujeto'});
        sujeto_rol.belongsTo(models.rol, {foreignKey: 'id_rol'});
    }
    return sujeto_rol;
};
