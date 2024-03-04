import 'package:flutter/material.dart';
import 'package:arosaje_flutter/services/ville_service.dart'; // Import de VillesService
import 'package:arosaje_flutter/models/ville_model.dart';

class VillesListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Ville>>(
      future: VillesService.getVilles(), // Utilisation de VillesService
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erreur de chargement');
        } else {
          final cities = snapshot.data!;
          return ListView.builder(
            itemCount: cities.length,
            itemBuilder: (context, index) {
              final ville = cities[index];
              return ListTile(
                title: Text(ville.nom),
                subtitle: Text(ville.desc ?? ''), // Utilisation du modèle Ville
              );
            },
          );
        }
      },
    );
  }
}
