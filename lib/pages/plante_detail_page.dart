import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:arosaje_flutter/models/plante_model.dart';
import 'package:arosaje_flutter/pages/message_form_page.dart';
import 'package:arosaje_flutter/secure_local_storage_token.dart';
import 'package:arosaje_flutter/services/garder_plante.dart';

class PlanteDetailPage extends StatelessWidget {
  final Plante plante;
  final TokenStorage _tokenStorage = TokenStorage();

  PlanteDetailPage({required this.plante});

  Future<bool> _isUserLoggedIn() async {
    List? token = await _tokenStorage.getToken();
    return token != null && token[0] != null;
  }

  Future<int?> _getUserId() async {
    List? token = await _tokenStorage.getToken();
    return token != null && token[2] != null ? int.tryParse(token[2]) : null;
  }

  void _handleGarderLaPlante(BuildContext context) async {
    bool isLoggedIn = await _isUserLoggedIn();
    if (isLoggedIn) {
      int? userId = await _getUserId();
      if (userId != null) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Confirmation"),
              content: Text("Êtes-vous sûr de vouloir garder cette plante ?"),
              actions: [
                TextButton(
                  child: Text("Non"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text("Oui"),
                  onPressed: () async {
                    Navigator.of(context).pop(); // Fermer le dialogue
                    bool success = await GarderPlanteService.garderPlante(plante.idPlante!, userId);
                    if (success) {
                      Fluttertoast.showToast(
                        msg: "Vous avez gardé la plante avec succès",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    } else {
                      Fluttertoast.showToast(
                        msg: "Une erreur s'est produite, veuillez réessayer",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  },
                ),
              ],
            );
          },
        );
      } else {
        Fluttertoast.showToast(
          msg: "Impossible de récupérer l'ID de l'utilisateur",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Vous devez être connecté",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Text(
                  "Détails de la plante",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
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
                    onPressed: () => _handleGarderLaPlante(context),
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
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: SingleChildScrollView(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: MessageForm(),
                              ),
                            ),
                          );
                        },
                      );
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
