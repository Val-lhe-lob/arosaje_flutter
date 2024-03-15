import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import '../config.dart';

class InscriptionService {
  Future<bool> inscription(String nom, String prenom, int age, String email, String mdp, String repeatmdp) async {
    try {
      if( mdp == repeatmdp){
      final response = await http.post(
        Uri.parse(Config.apiUrl + 'api/Utilisateurs'),
        body: jsonEncode({
      "nom": nom,
      "mdp": mdp,
      "email": email,
      "prenom":prenom,
      "age": age,}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print("ça a reussi normalement");
        
        return true;
      } else {
        print("code statut : " + response.statusCode.toString());
        return false;
      }}
      else{
        print("L'inscription n'a pas abouti");
        print(mdp + " = "+repeatmdp);
        return false;
      }
    } catch (e) {
      
      print('Exception during inscription: $e');
      return false;
    }
  }
}