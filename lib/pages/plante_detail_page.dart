import 'package:flutter/material.dart';
import 'package:arosaje_flutter/models/plante_model.dart';
import 'package:arosaje_flutter/pages/ville_page.dart';
import 'package:arosaje_flutter/pages/plante_page.dart';
import 'package:arosaje_flutter/pages/message_page.dart';
import 'package:arosaje_flutter/header.dart';
import 'package:arosaje_flutter/pages/connexion_page.dart'; 
import 'package:arosaje_flutter/pages/inscription_page.dart'; 


class PlanteDetailPage extends StatelessWidget {
  final Plante plante;

  PlanteDetailPage({required this.plante});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomHeader(),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Détails de la plante",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.yellow,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    plante.nom ?? "",
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
                    plante.description ?? '',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      // Logique pour garder la plante
                    },
                    child: Text(
                      'Garder la plante',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF55FFEB),
                      maximumSize: Size(150, double.infinity),
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      // logique a implementer
                    },
                    child: Text(
                      'Envoyer un message\nau propriétaire',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF81FF55),
                      fixedSize: Size(150, 60),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}