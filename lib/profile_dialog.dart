import 'package:arosaje_flutter/pages/connexion_page.dart';
import 'package:arosaje_flutter/pages/inscription_page.dart';
import 'package:flutter/material.dart';

class ProfileDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Vous n'êtes pas connecté"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConnexionPage()),
              );
            },
            child: Text('Se connecter'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(227, 231, 34, 1),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InscriptionPage()),
              );
            },
            child: Text('Créer un compte'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(227, 231, 34, 1),
            ),
          ),
        ],
      ),
    );
  }
}
