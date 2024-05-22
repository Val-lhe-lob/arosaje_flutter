import 'package:flutter/material.dart';
import 'package:arosaje_flutter/pages/plante_page.dart';
import 'package:arosaje_flutter/pages/ville_page.dart'; 
import 'package:arosaje_flutter/pages/message_page.dart'; 
import 'package:arosaje_flutter/header.dart';
import 'package:arosaje_flutter/pages/connexion_page.dart'; 
import 'package:arosaje_flutter/pages/inscription_page.dart'; 
import 'package:arosaje_flutter/pages/inscription_plante_page.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon Application',
      theme: ThemeData(
        primaryColor: Colors.white,
        fontFamily: 'IndieFlower',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomHeader(
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Color(0xFF008B16)],
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Arosaje c'est quoi ?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  
                  Image.asset(
                    'assets/image/arosaje-accueil-1.jpg',
                    width: 500,
                    height: 200,
                  ),SizedBox(height: 15),Text(
                    'A Rosa-je c’est une entreprise de conseil et d’entretien botanique qui vous permettra de garder vos plantes avec nos membres de la même ville que vous ! ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      // Logique pour voir la carte
                    },
                    child: Text('Voir la carte'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(227, 231, 34, 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xff7c94b6),
                image: DecorationImage(
                  image: AssetImage('assets/image/background-image.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: new ColorFilter.mode(Colors.white.withOpacity(0.5), BlendMode.dstATop),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Une plante à faire garder par notre communauté ? Vous voulez garder une plante ?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () {
                      // a faire la logique
                    },
                    child: Text('Voir les plantes'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(227, 231, 34, 1),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                                {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => InscriptionPlantePage()),
                        );
                      };
                    },
                    child: Text('Faire garder une plante'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(227, 231, 34, 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
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
