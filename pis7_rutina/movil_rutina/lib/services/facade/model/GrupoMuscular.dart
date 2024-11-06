import 'dart:convert';

class GrupoMuscular {
  int id = 0;
  String nombre = '';
  String descripcion = '';
  String external_id = '';

  GrupoMuscular();

  GrupoMuscular.fromMap(Map<dynamic, dynamic> mapa) {
    nombre = mapa['nombre'];
    descripcion = mapa['descripcion'];
    id = mapa['id'];
    external_id = mapa['external_id'];
  }

  @override
  String toString() {
    return 'Nombre: $nombre, Descripcion: $descripcion, Id: $id, External Id: $external_id';
  }

  static Map<String, dynamic> toMap(GrupoMuscular model) => <String, dynamic>{
        "nombre": model.nombre,
        "descripcion": model.descripcion,
        "id": model.id,
        "external_id": model.external_id
      };
  static String serialize(GrupoMuscular model) => json.encode(GrupoMuscular.toMap(model));
}
