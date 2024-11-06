'use strict';
module.exports = (sequelize, DataTypes) => {
    const unidad = sequelize.define('unidad', {
        nombre: { type: DataTypes.STRING(70), allowNull: false, unique:true },
        external_id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4},
        estado: {type: DataTypes.BOOLEAN, defaultValue: true}
    }, {
        freezeTableName: true
    });

    return unidad;
};
