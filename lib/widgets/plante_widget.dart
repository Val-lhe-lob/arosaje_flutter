import 'package:flutter/material.dart';
import 'package:arosaje_flutter/services/plante_service.dart'; // Import PlantesService
import 'package:arosaje_flutter/models/plante_model.dart';

class PlantesListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Plante>>(
      future: PlantesService.getPlantes(), // Call getPlantes() from PlantesService
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString()); // Handle error case
        } else {
          final plantes = snapshot.data!;
          return ListView.builder(
            itemCount: plantes.length,
            itemBuilder: (context, index) {
              final plante = plantes[index];
              return ListTile(
                title: Text(plante.nom),
                subtitle: Text(plante.desc ?? ''), // Use Plante model properties
              );
            },
          );
        }
      },
    );
  }
}
