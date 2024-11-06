'use strict';
module.exports = (sequelize, DataTypes) => {
    const mensaje = sequelize.define('mensaje', {
        contenido: { type: DataTypes.STRING(200), allowNull: false },
        external_id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
    }, {
        freezeTableName: true
    });
    mensaje.associate = function (models) {
        mensaje.belongsTo(models.cuenta, { foreignKey: 'id_cuenta', as: 'remitente' });
        mensaje.belongsTo(models.cuenta, { foreignKey: 'id_cuenta', as: 'destinatario' });
    }
    return mensaje;
};
