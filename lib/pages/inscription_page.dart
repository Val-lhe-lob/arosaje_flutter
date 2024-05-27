import 'package:flutter/material.dart';
import 'package:arosaje_flutter/services/inscription_service.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:arosaje_flutter/main.dart';

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
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () async {
                  var bytes = utf8.encode(_passwordController.text);
                  var digest = sha256.convert(bytes);
                  String hashedPassword = digest.toString();

                  var bytesRepeat = utf8.encode(_passwordController.text);
                  var digestRepeat = sha256.convert(bytesRepeat);
                  String hashedPasswordRepeat = digestRepeat.toString();

                  InscriptionService inscriptionService = InscriptionService();
                  await inscriptionService.inscription(
                    _nomController.text,
                    _prenomController.text,
                    int.parse(_ageController.text),
                    _emailController.text,
                    hashedPassword,
                    hashedPasswordRepeat,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
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
