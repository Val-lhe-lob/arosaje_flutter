import 'package:flutter/material.dart';
import 'package:arosaje_flutter/widgets/plantes_inscrites_widget.dart';

class PlantesUtilisateurPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Text(
                  "Mes Plantes Inscrites",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: UserPlantesWidget(),
          ),
        ],
      ),
    );
  }
}
