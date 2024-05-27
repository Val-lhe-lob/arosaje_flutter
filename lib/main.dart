import 'package:flutter/material.dart';
import 'package:arosaje_flutter/pages/plante_page.dart';
import 'package:arosaje_flutter/pages/ville_page.dart';
import 'package:arosaje_flutter/pages/message_page.dart';
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
      title: 'Arosaje',
      theme: ThemeData(
        primaryColor: Colors.white,
        fontFamily: 'IndieFlower',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PageController _pageController = PageController();

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  void _showProfileInfo() {
    bool isLoggedIn = true; // Set to true if the user is logged in

    if (isLoggedIn) {
      // Show profile information
      // Replace with your logic
      showDialog(
        context: context,
        builder: (BuildContext context) => ProfileDialog(),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Veuillez vous connecter ou créer un compte'),
          action: SnackBarAction(
            label: 'Se connecter',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConnexionPage()),
              );
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          HomeContent(
            onNavigateToPlantes: () => _onItemTapped(1),
            onNavigateToInscriptionPlante: () => _onItemTapped(2),
            onNavigateMap: ()=>_onItemTapped(3),
          ),
          PlanteOrVillePage(),
          InscriptionPlantePage(),
          VillesPage(),
          MessagesPage(),
          
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_florist, color: Colors.black),
            label: 'Plantes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add, color: Colors.black),
            label: 'Ajouter Plante',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map, color: Colors.black),
            label: 'Carte',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message, color: Colors.black),
            label: 'Messages',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showProfileInfo,
        tooltip: 'Profil et informations',
        child: Icon(Icons.account_circle),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final VoidCallback onNavigateToPlantes;
  final VoidCallback onNavigateToInscriptionPlante;
  final VoidCallback onNavigateMap;

  HomeContent({
    required this.onNavigateToPlantes,
    required this.onNavigateToInscriptionPlante,
    required this.onNavigateMap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
                ),
                SizedBox(height: 15),
                Text(
                  'A Rosa-je c’est une entreprise de conseil et d’entretien botanique qui vous permettra de garder vos plantes avec nos membres de la même ville que vous ! ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: onNavigateMap,
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
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.5),
                  BlendMode.dstATop,
                ),
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
                  onPressed: onNavigateToPlantes,
                  child: Text('Voir les plantes'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(227, 231, 34, 1),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: onNavigateToInscriptionPlante,
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
