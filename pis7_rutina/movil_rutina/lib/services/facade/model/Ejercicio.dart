import 'dart:convert';

class Ejercicio {
  int id = 0;
  String nombre = '';
  String external_id = '';
  int id_grupo_muscular = 0;

  Ejercicio();

  Ejercicio.fromMap(Map<dynamic, dynamic> mapa) {
    nombre = mapa['nombre'];
    id = mapa['id'];
    external_id = mapa['external_id'];
    id_grupo_muscular = mapa['id_grupo_muscular'];
  }

  @override
  String toString() {
    return 'Nombre: $nombre, Id: $id, External Id: $external_id, Id Grupo Muscular: $id_grupo_muscular';
  }

  static Map<String, dynamic> toMap(Ejercicio model) => <String, dynamic>{
        "nombre": model.nombre,
        "id": model.id,
        "external_id": model.external_id,
        "id_grupo_muscular": model.id_grupo_muscular
      };
  static String serialize(Ejercicio model) => json.encode(Ejercicio.toMap(model));
}
