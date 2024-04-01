import 'package:arosaje_flutter/models/utilisateur_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config.dart';
import '../secure_local_storage_token.dart';

class ConnexionService {
  final TokenStorage _tokenStorage = TokenStorage();

  Future<http.Response> getAuthenticatedData(String email, String mdp) async {
    List? token = await _tokenStorage.getToken();
    if (token != null) {
      return http.get(
        Uri.parse(Config.apiUrl+'/api/Utilisateurs/name/'+email), // Adjust URL as needed
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Include token in the header
        },
      );
    } else {
      throw Exception('Token not found'); // Handle the case where token is null
    }
  }
}
