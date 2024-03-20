import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:arosaje_flutter/services/connexion_service.dart';

class ConnexionPage extends StatefulWidget {
  @override
  _ConnexionPageState createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connexion'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {

                var bytes = utf8.encode(_passwordController.text);
                  var digest = sha256.convert(bytes); 
                  String hashedPassword = digest.toString();
                  var test = ConnexionService.connexion(
                    _emailController.text,
                    hashedPassword,
                    
                  );

                  if(test == 1){
                      
                  }
              //_emailController.text et _passwordController.text
              },
              child: Text('Se connecter'),
            ),
          ],
        ),
      ),
    );
  }
}
