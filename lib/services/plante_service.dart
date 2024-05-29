import 'package:dio/dio.dart';
import 'package:arosaje_flutter/models/plante_model.dart';
import '../config.dart';

class PlantesService {
  static Dio _dio = Dio();

  static Future<List<Plante>> getPlantes() async {
    try {
      final response = await _dio.get(
        Config.apiUrl + "/api/Plantes",
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        print('Data JSON: $data'); // Afficher les données JSON
        return data.map((json) => Plante.fromJson(json)).toList();
      } else {
        throw Exception('Échec de chargement des données: ${response.statusCode}');
      }
    } catch (error) {
      print('Erreur lors de la requête HTTP: $error');
      throw Exception('Erreur lors de la requête HTTP: $error');
    }
  }
}
