import 'package:arosaje_flutter/widgets/ville_widget.dart';
import 'package:flutter/material.dart';
import 'package:arosaje_flutter/pages/plante_page.dart';
import 'package:arosaje_flutter/pages/message_page.dart';
import 'package:arosaje_flutter/header.dart';
import 'package:arosaje_flutter/pages/connexion_page.dart'; 
import 'package:arosaje_flutter/pages/inscription_page.dart'; 

class VillesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Header(
          onHeaderLinkTap: (String text) {
            if (text == 'Plantes') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlantesPage()),
              );
            } else if (text == 'Villes') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VillesPage()),
              );
            } else if (text == 'Message') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MessagesPage()),
              );
            }
          },
          onProfileTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return ProfileDialog();
              },
            );
          },
        ),
      ),
      body: Container(
        child: VillesListWidget(),
      ),
    );
  }
}

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