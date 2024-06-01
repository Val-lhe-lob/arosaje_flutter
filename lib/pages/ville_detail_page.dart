import 'package:flutter/material.dart';
import 'package:arosaje_flutter/models/ville_model.dart';
import 'package:arosaje_flutter/services/ville_service.dart';
import 'package:arosaje_flutter/pages/plante_detail_page.dart';

class VilleDetailPage extends StatelessWidget {
  final Ville ville;

  VilleDetailPage({required this.ville});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Ville>(
        future: VillesService.getVillesWithPlantes().then(
          (villes) => villes.firstWhere((v) => v.idVille == ville.idVille),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Aucune donnée disponible'));
          } else {
            final villeWithPlantes = snapshot.data!;
            print('Ville with Plantes: ${villeWithPlantes.plantes}'); // Vérifier les plantes de la ville
            return Column(
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
                        villeWithPlantes.nom,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    villeWithPlantes.desc,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Plantes de ${villeWithPlantes.nom}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: villeWithPlantes.plantes?.length ?? 0,
                            itemBuilder: (context, index) {
                              final plante = villeWithPlantes.plantes![index];
                              return Container(
                                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                                padding: EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                  color: Color(0xFFFF6347), // Rouge coquelicot
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: ListTile(
                                  title: Text(plante.nom),
                                  subtitle: Text(plante.description ?? ''),
                                  trailing: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PlanteDetailPage(plante: plante),
                                        ),
                                      );
                                    },
                                    child: Text('Détail'),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
