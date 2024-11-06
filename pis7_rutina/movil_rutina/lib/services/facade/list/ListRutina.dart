import 'package:movil_rutina/services/facade/model/RespuestaGenerica.dart';
import 'package:movil_rutina/services/facade/model/Rutina.dart';

class ListRutina extends RespuestaGenerica {
  late List<Rutina> data = [];
  ListRutina();
  ListRutina.fromMap(List datos, int code) {
    datos.forEach((item) {
      Map<dynamic, dynamic> mapa = item;
      Rutina aux = Rutina.fromMap(mapa);
      data.add(aux);
    });
    this.msg = msg;
    this.code = code;
  }
}
