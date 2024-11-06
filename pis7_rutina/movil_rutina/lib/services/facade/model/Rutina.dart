import 'dart:convert';

class Rutina {
  int id = 0;
  String nombre = '';
  String descripcion = '';
  String external_id = '';
  late List<int> diasemana = [];

  Rutina();

  Rutina.fromMap(Map<dynamic, dynamic> mapa) {
    nombre = mapa['nombre'];
    descripcion = mapa['descripcion'];
    id = mapa['id'];
    mapa['diasSemana'].forEach((item) {
      diasemana.add(int.parse(item.toString()));
    });
    external_id = mapa['external_id'];
  }

  @override
  String toString() {
    return 'Nombre: $nombre, Descripcion: $descripcion, Id: $id, External Id: $external_id, Dias de Semana: $diasemana';
  }

  static Map<String, dynamic> toMap(Rutina model) => <String, dynamic>{
        "nombre": model.nombre,
        "descripcion": model.descripcion,
        "diasemana": model.diasemana,
        "id": model.id,
        "external_id": model.external_id
      };

  static String serialize(Rutina model) => json.encode(Rutina.toMap(model));
}
