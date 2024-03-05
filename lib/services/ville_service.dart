import 'package:http/http.dart' as http;
import 'package:arosaje_flutter/models/ville_model.dart';
import 'dart:convert';

class VillesService {
  static Future<List<Ville>> getVilles() async {
    try {
      var response = await http.get(
        Uri.parse('https://localhost:7239/api/Villes'));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Ville.fromJson(json)).toList();
      } else {
        throw Exception('Échec de chargement des données');
      }
    } catch (error) {
      throw Exception('Erreur lors de la requête HTTP: $error');
    }
  }
}
