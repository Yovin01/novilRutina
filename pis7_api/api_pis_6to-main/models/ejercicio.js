'use strict';
module.exports = (sequelize, DataTypes) => {
    const ejercicio = sequelize.define('ejercicio', {
        external_id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
        nombre: { type: DataTypes.STRING(40), allowNull: false },
    }, {
        freezeTableName: true
    });

    ejercicio.associate = function (models) {
        ejercicio.hasOne(models.explicacion, { foreignKey: 'id_ejercicio', as: 'descripcion'});
        ejercicio.hasOne(models.recomendacion, { foreignKey: 'id_ejercicio', as: 'recomendacion'});
        ejercicio.belongsTo(models.grupo_muscular, {foreignKey: 'id_grupo_muscular'});
        ejercicio.belongsTo(models.imagen, {foreignKey: 'id_imagen'});
        ejercicio.hasMany(models.marca_personal, {foreignKey: 'id_ejercicio', as: 'marca'});
        ejercicio.hasMany(models.rutina_ejercicio, {foreignKey: 'id_ejercicio', as: 'rutina_ejercicio'});
    }

    return ejercicio;
};
