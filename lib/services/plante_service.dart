import 'package:http/http.dart' as http;
import 'package:arosaje_flutter/models/plante_model.dart';
import 'dart:convert';
import '../config.dart';

class PlantesService {
  static Future<List<Plante>> getPlantes() async {
    try {
      var response = await http.get(
        Uri.parse(Config.apiUrl+"api/Plantes"));
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Plante.fromJson(json)).toList();
      } else {
        throw Exception('Échec de chargement des données');
      }
    } catch (error) {
      throw Exception('Erreur lors de la requête HTTP: $error');
    }
  }
}
