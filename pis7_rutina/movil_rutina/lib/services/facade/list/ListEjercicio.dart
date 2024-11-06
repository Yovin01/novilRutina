import 'package:movil_rutina/services/facade/model/RespuestaGenerica.dart';
import 'package:movil_rutina/services/facade/model/Ejercicio.dart';

class ListEjercicio extends RespuestaGenerica {
  late List<Ejercicio> data = [];
  ListEjercicio();
  ListEjercicio.fromMap(List datos, int code) {
    datos.forEach((item) {
      Map<dynamic, dynamic> mapa = item;
      Ejercicio aux = Ejercicio.fromMap(mapa);
      data.add(aux);
    });
    this.msg = msg;
    this.code = code;
  }
}
