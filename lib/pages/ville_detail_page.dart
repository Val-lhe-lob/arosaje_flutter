import 'package:flutter/material.dart';
import 'package:arosaje_flutter/models/ville_model.dart';
import 'package:arosaje_flutter/pages/ville_page.dart';
import 'package:arosaje_flutter/pages/plante_page.dart';
import 'package:arosaje_flutter/pages/message_page.dart';
import 'package:arosaje_flutter/header.dart';
import 'package:arosaje_flutter/pages/connexion_page.dart'; 
import 'package:arosaje_flutter/pages/inscription_page.dart'; 


class VilleDetailPage extends StatelessWidget {
  final Ville ville;

  VilleDetailPage({required this.ville});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomHeader(),
      ),
      body: Container(
        color: Colors.yellow,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                ville.nom,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                ville.desc ?? '',
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
                        'Plantes de ${ville.nom}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: ville.plantes.length,
                        itemBuilder: (context, index) {
                          final plante = ville.plantes[index];
                          return ListTile(
                            title: Text(plante.nom),
                            subtitle: Text(plante.description ?? ''),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}