import 'dart:convert';
import 'package:arosaje_flutter/secure_local_storage_token.dart';
import 'package:arosaje_flutter/widgets/send_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:arosaje_flutter/models/plante_model.dart';
import 'package:arosaje_flutter/services/garder_plante.dart';
import 'package:arosaje_flutter/services/photo_service.dart';
import 'package:arosaje_flutter/models/photo_model.dart';

class PlanteDetailPage extends StatefulWidget {
  final Plante plante;
  final TokenStorage _tokenStorage = TokenStorage();

  PlanteDetailPage({required this.plante});

  @override
  _PlanteDetailPageState createState() => _PlanteDetailPageState();
}

class _PlanteDetailPageState extends State<PlanteDetailPage> {
  int? senderId;
  Photo? _photo;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeSenderId();
    _fetchPhoto();
  }

  Future<void> _initializeSenderId() async {
    List? tokenData = await widget._tokenStorage.getToken();
    setState(() {
      senderId = int.tryParse(tokenData?[2] ?? '');
    });
  }

  Future<void> _fetchPhoto() async {
    PhotoService photoService = PhotoService();
    Photo? photo = await photoService.getPhoto(widget.plante.idPhoto!);

    setState(() {
      _photo = photo;
      _isLoading = false;
    });
  }

  Future<bool> _isUserLoggedIn() async {
    List? token = await widget._tokenStorage.getToken();
    return token != null && token[0] != null;
  }

  Future<int?> _getUserId() async {
    List? token = await widget._tokenStorage.getToken();
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
                    bool success = await GarderPlanteService.garderPlante(widget.plante.idPlante, userId);
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
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
                      // Affichage de l'image décodée à partir de la variable _photo.image
                      if (_photo != null)
                        Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: MemoryImage(base64Decode(_photo!.image!)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          widget.plante.nom,
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
                          widget.plante.description,
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
