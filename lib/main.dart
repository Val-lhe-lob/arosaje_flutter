import 'package:flutter/material.dart';
import 'package:arosaje_flutter/pages/plante_page.dart';
import 'package:arosaje_flutter/pages/ville_page.dart';
import 'package:arosaje_flutter/pages/map_page.dart'; // Importez la page de la carte
import 'header.dart';

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
              // Ajoutez votre logique pour le lien "Message" ici.
            }
          },
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
              padding: EdgeInsets.all(20),
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
                  Text(
                    'bla bla bla',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  Image.asset(
                    'assets/image/arosaje-accueil-1.jpg',
                    width: 500,
                    height: 200,
                  ),
                  SizedBox(height: 20), // Espacement entre le texte et le bouton
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MapPage()), // Redirige vers la page de la carte
                      );
                    },
                    child: Text('Voir la carte'), // Texte du bouton
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.9),
                image: DecorationImage(
                  image: AssetImage('assets/image/background-image.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Bla Bla',
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
                    child: Text('Test 1'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // a faire la logique
                    },
                    child: Text('Test 2'),
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

class HeaderLink extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const HeaderLink({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
