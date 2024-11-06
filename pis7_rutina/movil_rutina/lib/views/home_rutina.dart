import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movil_rutina/services/conexion.dart';
import 'package:movil_rutina/views/seleccion_grupom.dart';
import '../screems/checklist/cheack_list.dart';

class HomeRutina extends StatefulWidget {
  const HomeRutina({super.key});

  @override
  _HomeRutinaState createState() => _HomeRutinaState();
}

class _HomeRutinaState extends State<HomeRutina> {
  final conexion _conexion = conexion();
  final TextEditingController _nombreRutinaController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();

  List<String> diasWeek = [
    'Lunes',
    'Martes',
    'Miércoles',
    'Jueves',
    'Viernes',
    'Sábado',
    'Domingo'
  ];
  List<bool> selectedGroups = [false, false, false, false, false, false, false];

  void _updateSelectedGroups(List<bool> newSelectedGroups) {
    setState(() {
      selectedGroups = newSelectedGroups;
    });
  }

  Future<String> _crearRutina() async {
    List<int> diasSeleccionados = [];
    for (int i = 0; i < selectedGroups.length; i++) {
      if (selectedGroups[i]) {
        diasSeleccionados.add(i + 1);
      }
    }
    Map<String, dynamic> data = {
      "nombre": _nombreRutinaController.text,
      "descripcion": _descripcionController.text,
      "diasemana": diasSeleccionados.join(';'),
      "id_sujeto": "f31b9eef-47b4-11ef-979c-0242ac140002"
    };
    final respuesta =
        await _conexion.solicitudPost('rutinas', data, conexion.NO_TOKEN);
    Map<String, dynamic> mapa = jsonDecode(respuesta.info);
    if (respuesta.code == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Rutina creada correctamente.')));
      _nombreRutinaController.clear();
      _descripcionController.clear();
      setState(() {
        selectedGroups = [false, false, false, false, false, false, false];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error al crear rutina: ${respuesta.msg}")));
    }

    return mapa['info'];
  }

  @override
  Widget build(BuildContext context) {
    String external_id;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(6),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 40),
                    child: Text(
                      'Crear Rutina',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _nombreRutinaController,
                    decoration: const InputDecoration(
                      hintText: 'Ingresar el nombre de la rutina',
                      labelText: 'Nombre de rutina',
                      prefixIcon: Icon(
                        Icons.assignment_add,
                        color: Colors.green,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.all(Radius.circular(9.0)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _descripcionController,
                    decoration: const InputDecoration(
                      hintText: 'Ingresar una descripcion',
                      labelText: 'Descripcion',
                      prefixIcon: Icon(
                        Icons.article_outlined,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.all(Radius.circular(9.0)),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Seleccionar los dias entrenamiento',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Center(
                  child: GroupSelector(
                    items: diasWeek,
                    selectedGroups: selectedGroups,
                    onSelectionChanged: _updateSelectedGroups,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Limpiar campos de texto
                            _nombreRutinaController.clear();
                            _descripcionController.clear();
                            setState(() {
                              selectedGroups = [
                                false,
                                false,
                                false,
                                false,
                                false,
                                false,
                                false
                              ];
                            });
                          },
                          child: Text('Cancelar'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            external_id = await  _crearRutina();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SeleccionGrupoMuscular(
                                    external_id: external_id),
                              ),
                            );
                          },
                          child: Text(
                            'Crear',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
