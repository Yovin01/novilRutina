'use strict';
module.exports = (sequelize, DataTypes) => {
    const rutina = sequelize.define('rutina', {
        nombre: { type: DataTypes.STRING(70), allowNull: false },
        descripcion: { type: DataTypes.STRING(200), allowNull: true },
        external_id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    }, {
        freezeTableName: true
    });

    rutina.associate = function (models) {
        rutina.hasMany(models.rutina_diasemana, { foreignKey: 'id_rutina', as: 'rutina_diasemana' });
        rutina.hasMany(models.rutina_ejercicio, { foreignKey: 'id_rutina', as: 'rutina_ejercicio' });
        rutina.belongsTo(models.sujeto, { foreignKey: 'id_sujeto' });
    }

    return rutina;
};
