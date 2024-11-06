'use strict';

module.exports = (sequelize, DataTypes) => {
    const grupo_muscular = sequelize.define('grupo_muscular', {
        nombre: { type: DataTypes.ENUM('ABDOMINALES', 'BÍCEPS', 'ESPALDA', 'HOMBROS', 'PECHO', 'PIERNAS'), allowNull: false },
        descripcion: { type: DataTypes.STRING(100), allowNull: true },
        external_id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    }, {
        freezeTableName: true
    });
    grupo_muscular.associate = function (models) {
        grupo_muscular.hasMany(models.ejercicio, { foreignKey: 'id_grupo_muscular', as: 'ejercicio' });
    
    }
    return grupo_muscular;
};
