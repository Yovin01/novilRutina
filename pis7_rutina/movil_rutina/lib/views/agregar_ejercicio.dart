import 'package:flutter/material.dart';
import 'package:movil_rutina/screems/header/custon_header.dart';
import 'package:movil_rutina/screems/main/main_screem.dart';
import 'package:movil_rutina/services/conexion.dart';
import 'package:movil_rutina/services/facade/ListFacade.dart';
import 'package:movil_rutina/services/facade/list/ListEjercicio.dart';
import 'package:movil_rutina/views/calendar_dias.dart';

class AgregarEjercicio extends StatefulWidget {
  final String title;
  final String id;
  final String external_id;

  AgregarEjercicio({required this.title, required this.id, required this.external_id});

  @override
  _AgregarEjercicioState createState() => _AgregarEjercicioState();
}

class _AgregarEjercicioState extends State<AgregarEjercicio> {
  final conexion _com = new conexion();
  ListEjercicio ejercicios = ListEjercicio();
  List<int> selectedEjercicios = [];

  @override
  void initState() {
    super.initState();
    _loadEjercicios();
  }

  Future<void> _loadEjercicios() async {
    try {
      ListFacade laf = ListFacade();
      // Aquí asumimos que laf.listarEjercicios() devuelve una lista de ejercicios desde la base de datos
      ListEjercicio lista = await laf.listarEjercicios(widget.id);
      setState(() {
        ejercicios = lista;
      });
    } catch (e) {
      print("Error loading exercises: $e");
    }
  }

  Future<void> _guardarSeleccion() async {
    try {
      // Crear la cadena de ejercicios seleccionados
      String ejerciciosSeleccionados = selectedEjercicios.join(';');
      Map<String, dynamic> data = {
        'ejercicios': ejerciciosSeleccionados,
        'external_id': widget.external_id,
      };
      final response = await _com.solicitudPost('rutinas/addEjercicio', data, conexion.NO_TOKEN);

      if (response.code == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ejercicios guardados exitosamente')),
        );
      } else {
        throw Exception('Failed to save exercises');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar ejercicios')),
      );
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(title: 'Seleccionar ejercicios para ${widget.title}'),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: ejercicios.data.map((ejercicio) {
                return CheckboxListTile(
                  title: Text(ejercicio.nombre),
                  value: selectedEjercicios.contains(ejercicio.id),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value == true) {
                        selectedEjercicios.add(ejercicio.id);
                      } else {
                        selectedEjercicios.remove(ejercicio.id);
                      }
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                   Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CalendarDias(), // Navega a la página principal
                      ),
                    ); // Cancelar y volver a la pantalla anterior
                  },
                  child: Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: _guardarSeleccion,
                  child: Text(
                    'Agregar',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
