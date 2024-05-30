import 'package:dio/dio.dart';
import 'package:arosaje_flutter/models/ville_model.dart';
import '../config.dart';

class VillesService {
  static Dio _dio = Dio();

  static Future<List<Ville>> getVilles() async {
    try {
      var response = await _dio.get(
        Config.apiUrl + '/api/Villes',
        options: Options(
          headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        print('Data JSON: $data'); // Afficher les données JSON
        return data.map((json) => Ville.fromJson(json)).toList();
      } else {
        throw Exception('Échec de chargement des données: ${response.statusCode}');
      }
    } catch (error) {
      print('Erreur lors de la requête HTTP: $error');
      throw Exception('Erreur lors de la requête HTTP: $error');
    }
  }
}
