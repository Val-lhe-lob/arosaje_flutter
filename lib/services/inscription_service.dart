import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../config.dart';

class InscriptionService {
  Dio _dio = Dio();

  Future<int?> _getUserIdByEmail(String email) async {
    try {
      final response = await _dio.get(
        Config.apiUrl + '/api/Utilisateurs/idByMail/$email',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        return response.data as int;
      } else {
        throw Exception("Failed to retrieve user ID. Code: ${response.statusCode}");
      }
    } catch (e) {
      print('Exception while retrieving user ID: $e');
      return null;
    }
  }

  Future<bool> inscription(String nom, String prenom, int age, String email, String mdp, String repeatmdp) async {
    try {
      if (mdp != repeatmdp) {
        Fluttertoast.showToast(
          msg: "Les mots de passe ne correspondent pas.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return false;
      }

      if (mdp.length < 8) {
        Fluttertoast.showToast(
          msg: "Le mot de passe doit avoir au moins 8 caractères.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        return false;
      }

      final response = await _dio.post(
        Config.apiUrl + '/api/Utilisateurs',
        data: {
          "nom": nom,
          "mdp": mdp,
          "email": email,
          "prenom": prenom,
          "age": age,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Inscription réussie pour l'utilisateur: $email");

        // Get the user ID using the email
        int? userId = await _getUserIdByEmail(email);

        if (userId == null) {
          throw Exception("Failed to retrieve the user ID after registration.");
        }

        final membreResponse = await _dio.post(
          Config.apiUrl + '/api/Membres',
          data: {
            "idUtilisateur": userId,
          },
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ),
        );

        if (membreResponse.statusCode == 200 || membreResponse.statusCode == 201) {
          print("Enregistrement réussi en tant que membre.");
          return true;
        } else {
          throw Exception("Échec de l'insertion dans Membre. Code: ${membreResponse.statusCode}");
        }
      } else {
        throw Exception("Échec de l'inscription. Code: ${response.statusCode}");
      }
    } catch (e) {
      print('Exception lors de l\'inscription: $e');
      return false;
    }
  }
}
