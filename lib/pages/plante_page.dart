import 'package:flutter/material.dart';
import 'package:arosaje_flutter/widgets/ville_widget.dart';
import 'package:arosaje_flutter/widgets/plante_widget.dart';

class PlanteOrVillePage extends StatefulWidget {
  @override
  _planteOrVillePage createState() => _planteOrVillePage();
}

class _planteOrVillePage extends State<PlanteOrVillePage> {
  String selectedButton = 'plantes'; // Par défaut, afficher la liste des plantes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedButton = 'plantes';
                    });
                  },
                  child: Text('Toutes les plantes'),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedButton = 'villes';
                    });
                  },
                  child: Text('Par Villes'),
                ),
              ],
            ),
          ),
          Expanded(
            child: selectedButton == 'plantes'
                ? PlantesListWidget()
                : VillesListWidget(),
          ),
        ],
      ),
    );
  }
}
