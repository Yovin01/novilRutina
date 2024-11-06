import 'package:flutter/material.dart';
import 'package:movil_rutina/services/facade/ListFacade.dart';
import 'package:movil_rutina/services/facade/list/ListRutina.dart';
import 'package:movil_rutina/services/facade/model/Rutina.dart';

class CalendarDias extends StatefulWidget {
  const CalendarDias({super.key});
  @override
  _CalendarDiasState createState() => _CalendarDiasState();
}

class _CalendarDiasState extends State<CalendarDias> {
  String external_id = "f31b9eef-47b4-11ef-979c-0242ac140002";
  ListRutina rutina = ListRutina();
  Map<int, String> diasSemana = {
    1: 'Lunes',
    2: 'Martes',
    3: 'Miércoles',
    4: 'Jueves',
    5: 'Viernes',
    6: 'Sábado',
    7: 'Domingo'
  };

  // Inicializa un mapa para almacenar rutinas agrupadas por día
  Map<String, List<Rutina>> rutinasPorDia = {};

  Future<void> _RutinaDias() async {
    ListFacade laf = ListFacade();
    ListRutina lista = await laf.listarRutinas(external_id);
    rutina = lista;
    // Limpia el mapa antes de rellenarlo
    rutinasPorDia.clear();
    for (var r in lista.data) {
      for (var dia in r.diasemana) {
        String diaNombre = diasSemana[dia]!;
        if (rutinasPorDia[diaNombre] == null) {
          rutinasPorDia[diaNombre] = [];
        }
        rutinasPorDia[diaNombre]!.add(r);
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _RutinaDias(); // Llama a la función para cargar las rutinas al iniciar
  }

  @override
  void didUpdateWidget(covariant CalendarDias oldWidget) {
    super.didUpdateWidget(oldWidget);
    _RutinaDias(); // Llama a la función para actualizar las rutinas cuando el widget se actualiza
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text('Calendario',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: diasSemana.values.map((dia) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey, // Color del borde
                      width: 1.0, // Ancho del borde
                    ),
                    borderRadius: BorderRadius.circular(
                        8.0), // Radio de las esquinas del borde
                  ),
                  margin: EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 8.0), // Margen alrededor del contenedor
                  child: ExpansionTile(
                    title: Text(
                      dia,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    children: (rutinasPorDia[dia] ?? []).map((rutina) {
                      return ListTile(
                        title: Text(rutina.nombre),
                        subtitle: Text(rutina.descripcion),
                        onTap: () {
                          // Aquí puedes manejar la acción al presionar una rutina.
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('${rutina.nombre} seleccionada'),
                          ));
                        },
                      );
                    }).toList(),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
