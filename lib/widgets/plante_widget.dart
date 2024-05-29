import 'package:flutter/material.dart';
import 'package:arosaje_flutter/services/plante_service.dart';
import 'package:arosaje_flutter/models/plante_model.dart';
import 'package:arosaje_flutter/pages/plante_detail_page.dart';

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
              return Container(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(229,255,123,1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: Text(plante.nom ?? ''),
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
          );
        }
      },
    );
  }
}
