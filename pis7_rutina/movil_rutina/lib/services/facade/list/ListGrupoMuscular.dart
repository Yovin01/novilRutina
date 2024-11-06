import 'package:movil_rutina/services/facade/model/RespuestaGenerica.dart';
import 'package:movil_rutina/services/facade/model/GrupoMuscular.dart';

class ListGrupoMuscular extends RespuestaGenerica {
  late List<GrupoMuscular> data = [];
  ListGrupoMuscular();
  ListGrupoMuscular.fromMap(List datos, int code) {
    datos.forEach((item) {
      Map<dynamic, dynamic> mapa = item;
      GrupoMuscular aux = GrupoMuscular.fromMap(mapa);
      data.add(aux);
    });
    this.msg = msg;
    this.code = code;
  }
}
