import 'dart:ffi';
import 'dart:ui';
import 'package:arosaje_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:arosaje_flutter/services/connexion_service.dart';
import 'package:arosaje_flutter/services/user_information_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
              onPressed: () async {

                var bytes = utf8.encode(_passwordController.text);
                  var digest = sha256.convert(bytes); 
                  String hashedPassword = digest.toString();
                  var connexionService = ConnexionService();
                  var test = connexionService.authenticate(
                    _emailController.text,
                    hashedPassword,
                    
                  );
                  if(await test){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));}
                  else{
                    Fluttertoast.showToast(
                      msg: "La connexion s'est mal passé, veuillez réessayer s'il vous plaît",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  }

                
              },
              child: Text('Se connecter'),
            ),
          ],
        ),
      ),
    );
  }
}
