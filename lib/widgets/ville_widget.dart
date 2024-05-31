import 'package:flutter/material.dart';
import 'package:arosaje_flutter/services/ville_service.dart';
import 'package:arosaje_flutter/models/ville_model.dart';
import 'package:arosaje_flutter/pages/ville_detail_page.dart';

class VillesListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Ville>>(
      future: VillesService.getVillesWithPlantes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else {
          final villes = snapshot.data;
          if (villes == null || villes.isEmpty) {
            return Center(child: Text('Aucune donnée disponible'));
          } else {
            return ListView.builder(
              itemCount: villes.length,
              itemBuilder: (context, index) {
                final ville = villes[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 246, 250, 1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        title: Text(ville.nom),
                        subtitle: Text(ville.desc),
                      ),
                      SizedBox(height: 8.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VilleDetailPage(ville: ville),
                            ),
                          );
                        },
                        child: Text('Voir toutes les plantes de cette ville'),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        }
      },
    );
  }
}
