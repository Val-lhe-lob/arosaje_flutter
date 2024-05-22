import 'package:arosaje_flutter/pages/connexion_page.dart';
import 'package:arosaje_flutter/pages/inscription_page.dart';
import 'package:arosaje_flutter/pages/message_page.dart';
import 'package:arosaje_flutter/pages/plante_page.dart';
import 'package:arosaje_flutter/pages/ville_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomHeader extends StatelessWidget {
  final Function(String)? onHeaderLinkTap;
  final VoidCallback? onProfileTap;

  const CustomHeader({
    Key? key,
    this.onHeaderLinkTap,
    this.onProfileTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          InkWell(
            onTap: onProfileTap,
            child: Image.asset(
              'assets/image/logo.png', // Remplacez 'your_image.png' par le chemin de votre image
              width: 40, // Définissez la largeur de l'image selon vos besoins
              height: 40, // Définissez la hauteur de l'image selon vos besoins
            ),
          ),
          SizedBox(width: 16), // Ajouter un espace entre le logo et les liens
          HeaderLink(
            text: 'Plantes',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlantesPage()),
              );
            },
          ),
          SizedBox(width: 8), // Espacement entre les liens
          HeaderLink(
            text: 'Villes',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VillesPage()),
              );
            },
          ),
          SizedBox(width: 8), // Espacement entre les liens
          HeaderLink(
            text: 'Messages',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MessagesPage()),
              );
            },
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.account_circle),
          onPressed: onProfileTap ?? () {},
        ),
      ],
      backgroundColor: Colors.white,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(2.0),
        child: Container(
          color: Colors.black,
          height: 1,
        ),
      ),
    );
  }
}

class HeaderLink extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const HeaderLink({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
              // Afficher le toast avec les boutons de connexion et d'inscription
              Fluttertoast.showToast(
                msg: "Vous n'êtes pas connecté",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
                webShowClose: true,
              );
            },
            child: Text('Se connecter'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(227, 231, 34, 1),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Afficher la page d'inscription
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