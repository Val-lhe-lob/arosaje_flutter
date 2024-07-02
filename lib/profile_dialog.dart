import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:arosaje_flutter/pages/plantes_inscrites_page.dart';
import 'package:arosaje_flutter/pages/connexion_page.dart';
import 'package:arosaje_flutter/pages/inscription_page.dart';
import 'package:arosaje_flutter/services/deconnexion_service.dart';

class ProfileDialog extends StatelessWidget {
  final VoidCallback onLogout; // Définir le callback pour la déconnexion

  ProfileDialog({required this.onLogout});

  void showUserInfoDialog(BuildContext context, String userName, String email) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Informations de l'utilisateur"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Nom d'utilisateur: $userName"),
              SizedBox(height: 8),
              Text("Email: $email"),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlantesUtilisateurPage()),
                );
              },
              child: Text('Voir mes plantes inscrites'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fermer'),
            ),
            ElevatedButton(
              onPressed: () async {
                await DeconnexionService().deconnexion(onLogout); // Appel du service de déconnexion avec le callback
                Navigator.of(context).pop();
                // Optionnellement, vous pouvez afficher un message ou un toast indiquant que l'utilisateur s'est déconnecté
                Fluttertoast.showToast(
                  msg: "Déconnexion réussie",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                );
              },
              child: Text('Déconnexion'),
            ),
          ],
        );
      },
    );
  }

  void showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
