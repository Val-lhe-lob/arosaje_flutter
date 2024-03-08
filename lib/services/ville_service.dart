import 'package:http/http.dart' as http;
import 'package:arosaje_flutter/models/ville_model.dart';
import 'dart:convert';
import '../config.dart';

class VillesService {
  static Future<List<Ville>> getVilles() async {
    try {
      var client = http.Client();
      var response = await client.get(
        Uri.parse(Config.apiUrl+'api/Villes'),
        headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
      );

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
