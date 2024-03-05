import 'package:flutter/material.dart';
import 'package:arosaje_flutter/services/ville_service.dart'; // Import VillesService
import 'package:arosaje_flutter/models/ville_model.dart';

class VillesListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Ville>>(
      future: VillesService.getVilles(), // Call getVilles() from VillesService
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString()); // Handle error case
        } else {
          final villes = snapshot.data!;
          return ListView.builder(
            itemCount: villes.length,
            itemBuilder: (context, index) {
              final ville = villes[index];
              return ListTile(
                title: Text(ville.nom),
                subtitle: Text(ville.desc ?? ''), // Use Ville model properties
              );
            },
          );
        }
      },
    );
  }
}
