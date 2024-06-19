import 'package:dio/dio.dart';
import 'package:arosaje_flutter/models/plante_model.dart';
import '../config.dart';

class PlantesService {
  static Dio _dio = Dio()..interceptors.add(LogInterceptor(responseBody: true));

  static Future<List<Plante>> getPlantes() async {
    try {
      var response = await _dio.get(
        Config.apiUrl + '/api/Plantes',
        options: Options(
          headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Plante.fromJson(json)).toList();
      } else {
        throw Exception('Échec de chargement des données: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Erreur lors de la requête HTTP: $error');
    }
  }

  static Future<List<Plante>> getPlantesByUserId(int userId) async {
    try {
      var response = await _dio.get(
        Config.apiUrl + '/api/Plantes',
        options: Options(
          headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data
            .map((json) => Plante.fromJson(json))
            .where((plante) => plante.idUtilisateur == userId)
            .toList();
      } else {
        throw Exception('Échec de chargement des données: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Erreur lors de la requête HTTP: $error');
    }
  }
}
