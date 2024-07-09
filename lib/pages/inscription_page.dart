import 'package:flutter/material.dart';
import 'package:arosaje_flutter/services/inscription_service.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:arosaje_flutter/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InscriptionPage extends StatefulWidget {
  @override
  _InscriptionPageState createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  late TextEditingController _nomController;
  late TextEditingController _prenomController;
  late TextEditingController _ageController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _repeatPasswordController;
  bool _isConsentChecked = false;

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController();
    _prenomController = TextEditingController();
    _ageController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _repeatPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nomController.dispose();
    _prenomController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  void _showPrivacyPolicyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Politique de Confidentialité'),
          content: SingleChildScrollView(
            child: Text(
              "Nous nous engageons à protéger votre vie privée. Cette politique de confidentialité explique comment nous collectons, utilisons, stockons et protégeons vos données personnelles.\n\n"
              "1. **Collecte des données personnelles**\n"
              "Nous collectons les informations que vous fournissez lors de votre inscription, telles que votre nom, prénom, âge, adresse email et mot de passe. Ces données sont nécessaires pour créer et gérer votre compte.\n\n"
              "2. **Utilisation des données personnelles**\n"
              "Vos données personnelles sont utilisées pour gérer votre compte, vous fournir les services demandés et améliorer nos services. Nous pouvons également utiliser vos données pour vous envoyer des informations importantes concernant notre service.\n\n"
              "3. **Partage des données personnelles**\n"
              "Nous ne partageons pas vos données personnelles avec des tiers, sauf si cela est nécessaire pour fournir nos services ou si la loi nous y oblige.\n\n"
              "4. **Sécurité des données personnelles**\n"
              "Nous prenons des mesures appropriées pour protéger vos données personnelles contre l'accès non autorisé, la divulgation, l'altération ou la destruction. Toutefois, aucune méthode de transmission sur Internet ou de stockage électronique n'est totalement sécurisée.\n\n"
              "5. **Durée de conservation des données**\n"
              "Vos données personnelles seront conservées pendant toute la durée de votre utilisation de nos services et pendant une période de trois ans après la dernière activité sur votre compte. Au-delà de cette période, vos données seront supprimées ou anonymisées, sauf si elles sont nécessaires pour respecter nos obligations légales, résoudre des litiges ou faire respecter nos accords.\n\n"
              "6. **Droit à l'oubli**\n"
              "Vous avez le droit de demander la suppression de vos données personnelles à tout moment. Pour exercer ce droit, veuillez nous contacter à l'adresse indiquée sur notre site. Nous nous engageons à répondre à votre demande dans un délai raisonnable et à supprimer vos données, sauf si leur conservation est nécessaire pour respecter nos obligations légales, résoudre des litiges ou faire respecter nos accords.\n\n"
              "7. **Vos droits**\n"
              "Vous avez le droit d'accéder à vos données personnelles, de les corriger, de les supprimer ou de limiter leur traitement. Vous pouvez exercer ces droits en nous contactant à l'adresse indiquée sur notre site.\n\n"
              "8. **Modifications de la politique de confidentialité**\n"
              "Nous pouvons mettre à jour cette politique de confidentialité de temps à autre. Nous vous informerons de toute modification en publiant la nouvelle politique sur notre site.\n\n"
            ),
          ),
          actions: [
            TextButton(
              child: Text('Fermer'),
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
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
                      "Inscription",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              TextField(
                controller: _nomController,
                decoration: InputDecoration(
                  labelText: 'Nom d\'utilisateur',
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: _prenomController,
                decoration: InputDecoration(
                  labelText: 'Prénom',
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Âge',
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Adresse email',
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: _repeatPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Répéter le mot de passe',
                ),
              ),
              SizedBox(height: 12.0),
              Row(
                children: [
                  Checkbox(
                    value: _isConsentChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        _isConsentChecked = value!;
                      });
                    },
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _showPrivacyPolicyDialog();
                      },
                      child: Text(
                        "J'accepte que mes données personnelles soient traitées conformément à la politique de confidentialité.",
                        style: TextStyle(decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () async {
                  if (!_isConsentChecked) {
                    Fluttertoast.showToast(
                      msg: "Vous devez accepter la politique de confidentialité.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                    );
                    return;
                  }

                  if (_passwordController.text.length < 8) {
                    Fluttertoast.showToast(
                      msg: "Le mot de passe doit avoir au moins 8 caractères.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                    );
                    return;
                  }

                  if (_passwordController.text != _repeatPasswordController.text) {
                    Fluttertoast.showToast(
                      msg: "Les mots de passe ne correspondent pas.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                    );
                    return;
                  }

                  var bytes = utf8.encode(_passwordController.text);
                  var digest = sha256.convert(bytes);
                  String hashedPassword = digest.toString();

                  var bytesRepeat = utf8.encode(_repeatPasswordController.text);
                  var digestRepeat = sha256.convert(bytesRepeat);
                  String hashedPasswordRepeat = digestRepeat.toString();

                  InscriptionService inscriptionService = InscriptionService();
                  final success = await inscriptionService.inscription(
                    _nomController.text,
                    _prenomController.text,
                    int.parse(_ageController.text),
                    _emailController.text,
                    hashedPassword,
                    hashedPasswordRepeat,
                  );
                  if (success) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  } else {
                    print("Inscription failed");
                  }
                },
                child: Text('S\'inscrire'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
