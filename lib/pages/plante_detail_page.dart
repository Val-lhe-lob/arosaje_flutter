import 'package:arosaje_flutter/secure_local_storage_token.dart';
import 'package:flutter/material.dart';
import 'package:arosaje_flutter/models/plante_model.dart';
import 'package:arosaje_flutter/pages/message_form_page.dart';

class PlanteDetailPage extends StatefulWidget {
  final Plante plante;

  PlanteDetailPage({required this.plante});

  @override
  _PlanteDetailPageState createState() => _PlanteDetailPageState();
}

class _PlanteDetailPageState extends State<PlanteDetailPage> {
  int? senderId;

  @override
  void initState() {
    super.initState();
    _initializeSenderId();
  }

  Future<void> _initializeSenderId() async {
    TokenStorage tokenStorage = TokenStorage();
    List? tokenData = await tokenStorage.getToken();
    setState(() {
      senderId = int.tryParse(tokenData?[2] ?? '');
    });
  }

  void _showLoginRequiredDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Connexion requise'),
          content: Text('Vous devez vous connecter ou vous inscrire pour envoyer un message.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
                    widget.plante.nom ?? "",
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
                    widget.plante.description ?? '',
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
                      if (senderId == null) {
                        _showLoginRequiredDialog();
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: SingleChildScrollView(
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.8,
                                  child: MessageForm(
                                    senderId: senderId!,
                                    receiverId: widget.plante.idUtilisateur,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
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
