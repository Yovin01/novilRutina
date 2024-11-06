import 'dart:convert';

import 'package:movil_rutina/services/conexion.dart';
import 'package:movil_rutina/services/facade/list/ListEjercicio.dart';
import 'package:movil_rutina/services/facade/list/ListGrupoMuscular.dart';
import 'package:movil_rutina/services/facade/list/ListRutina.dart';

class ListFacade {
  conexion _conn = new conexion();
  Future<ListRutina> listarRutinas(String external_id) async {
    var response = await _conn.solicitudGet('rutinas/$external_id', "NO");
    return _responseRutina((response.code == 200) ? response.info : null);
  }

  Future<ListGrupoMuscular> listarGrupoMusculars() async {
    var response = await _conn.solicitudGet('gruposmusculares', "NO");
    return _responseGrupoMuscular((response.code != 200) ? null:response.info);
  }
   Future<ListEjercicio> listarEjercicios(String id) async {
    var response = await _conn.solicitudGet('ejercicios/$id', "NO");
    return _responseEjercicios((response.code != 200) ? null:response.info);
  }


}

ListRutina _responseRutina(dynamic data) {
  var sesion = ListRutina();
  if (data != null) {
    
    Map<String, dynamic> mapa = jsonDecode(data);
    if (mapa.containsKey("info")) {
      List datos = jsonDecode(jsonEncode(mapa["info"]));
      sesion = ListRutina.fromMap(datos, int.parse(mapa["code"].toString()));
    } else {
      List myList = List.empty();
      sesion = ListRutina.fromMap(myList, int.parse(mapa["code"].toString()));
    }
  }
  return sesion;
}

ListGrupoMuscular _responseGrupoMuscular(dynamic data) {
  var sesion = ListGrupoMuscular();
  if (data != null) {
    Map<String, dynamic> mapa = jsonDecode(data);
    if (mapa.containsKey("info")) {
      List datos = jsonDecode(jsonEncode(mapa["info"]));
      sesion = ListGrupoMuscular.fromMap(datos, int.parse(mapa["code"].toString()));
    } else {
      List myList = List.empty();
      sesion = ListGrupoMuscular.fromMap(myList, int.parse(mapa["code"].toString()));
    }
  }
  return sesion;
}

ListEjercicio _responseEjercicios(dynamic data) {
  var sesion = ListEjercicio();
  if (data != null) {
    Map<String, dynamic> mapa = jsonDecode(data);
    if (mapa.containsKey("info")) {
      List datos = jsonDecode(jsonEncode(mapa["info"]));
      sesion = ListEjercicio.fromMap(datos, int.parse(mapa["code"].toString()));
    } else {
      List myList = List.empty();
      sesion = ListEjercicio.fromMap(myList, int.parse(mapa["code"].toString()));
    }
  }
  return sesion;
}