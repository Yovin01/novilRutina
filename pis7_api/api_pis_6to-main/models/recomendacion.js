'use strict';

module.exports = (sequelize, DataTypes) => {
    const recomendacion = sequelize.define('recomendacion', {
        nombre: {type: DataTypes.STRING(20), unique:true },
        estado: {type: DataTypes.BOOLEAN, defaultValue: true},
        external_id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    }, {freezeTableName: true});

    return recomendacion;    
};
