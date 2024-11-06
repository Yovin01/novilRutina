import 'package:flutter/material.dart';
import 'package:movil_rutina/screems/checklist/group_selector.dart';
import 'package:movil_rutina/screems/header/custon_header.dart';
import 'package:movil_rutina/views/agregar_ejercicio.dart';

class SeleccionGrupoMuscular extends StatefulWidget {
  final String external_id;

  SeleccionGrupoMuscular({required this.external_id});

  @override
  _SeleccionGrupoMuscularState createState() => _SeleccionGrupoMuscularState();
}

class _SeleccionGrupoMuscularState extends State<SeleccionGrupoMuscular> {
  // Lista de grupos musculares
  final List<String> gruposMusculares = [
    'Abdominales',
    'Bíceps',
    'Espalda',
    'Hombros',
    'Pecho',
    'Piernas',
  ];

  // Índice del grupo muscular seleccionado
  int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomHeader(title: 'Selecciona el grupo muscular'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: OneSelector(
                items: gruposMusculares,
                selectedIndex: selectedIndex ,
                onSelectionChanged: (int? index) {
                  setState(() {
                    selectedIndex = index!;
                  });
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (selectedIndex != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AgregarEjercicio(
                          external_id: widget.external_id,
                          title: gruposMusculares[selectedIndex!],
                          id: selectedIndex!.toString(),
                        ),
                      ),
                    );
                  } else {
                    // Mostrar un mensaje si no se ha seleccionado ningún grupo muscular
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Por favor, selecciona un grupo muscular.'),
                      ),
                    );
                  }
                },
                child: Text(
                  'Confirmar',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
