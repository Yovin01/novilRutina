'use strict';

module.exports = (sequelize, DataTypes) => {
const dias_semana = sequelize.define('dias_semana', {
    dia: { type: DataTypes.ENUM, values: ['LUNES', 'MARTES', 'MIERCOLES', 'JUEVES', 'VIERNES', 'SABADO', 'DOMINGO'], allowNull: false },
    external_id: { type: DataTypes.UUID, defaultValue: DataTypes.UUIDV4 },
}, {
    freezeTableName: true
});

dias_semana.associate = function (models) {
     dias_semana.hasMany(models.rutina_diasemana, {foreignKey: 'id_dias_semana', as: 'dias_semana'});
}
  return dias_semana;
};
