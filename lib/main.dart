import 'package:arosaje_flutter/pages/plante_page.dart';
import 'package:flutter/material.dart';
import 'package:arosaje_flutter/pages/ville_page.dart';

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
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/image/logo.png',
              width: 50,
              height: 50,
            ),
            Row(
              children: [
                HeaderLink(
                    text: 'Plantes',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PlantesPage()),
                      );
                      // a faire la logique
                    }),
                SizedBox(width: 2),
                HeaderLink(
                    text: 'Villes',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => VillesPage()),
                      );
                    }),
                SizedBox(width: 2),
                HeaderLink(
                    text: 'Message',
                    onPressed: () {
                      // a faire la logique
                    }),
              ],
            ),
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                // a faire la logique
              },
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(2.0),
          child: Container(
            color: Colors.black,
            height: 1,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: DecoratedBox(
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
                  ],
                ),
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


