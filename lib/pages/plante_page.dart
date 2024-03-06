import 'package:flutter/material.dart';
import 'package:arosaje_flutter/widgets/plante_widget.dart';
class PlantesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plantes'),
      ),
      body: PlantesListWidget(),
    );
  }
}