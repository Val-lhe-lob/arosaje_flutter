import 'package:http/http.dart' as http;
import 'package:arosaje_flutter/models/utilisateur_model.dart';
import 'dart:convert';
import '../config.dart';

class ConnexionService {
  static Future<int> connexion(String email, String password) async {
    try {
      var client = http.Client();
      var response = await client.get(
        Uri.parse(Config.apiUrl + 'api/Utilisateurs/name/' + email),
        headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var utilisateurJson = jsonDecode(response.body);
        Utilisateur utilisateur = Utilisateur.fromJson(utilisateurJson);
        
        if (utilisateur != null) {
          if (utilisateur.mdp == password) {
            return 1; // L'utilisateur existe et password correct
          } else {
            return 3; // L'utilisateur existe mais mauvais mdp
          }
        } else {
          return 2; // L'utilisateur n'existe pas
        }
      } else {
        return 4; // Error in API response
      }
    } catch (error) {
      throw Exception('Erreur lors de la requête HTTP: $error');
    }
    
    return 4; 
  }
}
