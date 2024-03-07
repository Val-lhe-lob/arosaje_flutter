import 'package:flutter/material.dart';
import 'package:arosaje_flutter/services/plante_service.dart';
import 'package:arosaje_flutter/models/plante_model.dart';

class PlantesListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Plante>>(
      future: PlantesService.getPlantes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else {
          final plantes = snapshot.data!;
          return ListView.builder(
            itemCount: plantes.length,
            itemBuilder: (context, index) {
              final plante = plantes[index];
              return ListTile(
                title: Text(plante.nom),
                subtitle: Text(plante.desc ?? ''),
              );
            },
          );
        }
      },
    );
  }
}
