import 'package:dio/dio.dart';
import 'package:arosaje_flutter/models/plante_model.dart';
import '../config.dart';

class PlantesService {
  static Dio _dio = Dio()..interceptors.add(LogInterceptor(responseBody: true));

  static Future<List<Plante>> getPlantes() async {
    print('getPlantes: Fetching plantes from API');
    try {
      var response = await _dio.get(
        Config.apiUrl + '/api/Plantes',
        options: Options(
          headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
        ),
      );

      print('getPlantes: Response received with status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        print('getPlantes: Response data: $data');
        
        final List<Map<String, dynamic>> jsonList = List<Map<String, dynamic>>.from(data);
        print('getPlantes: JSON list: $jsonList');

        var plantesList = jsonList.map((json) => Plante.fromJson(json)).toList();
        print('getPlantes: Parsed plantes list: $plantesList');

        return plantesList;
      } else {
        throw Exception('Échec de chargement des données: ${response.statusCode}');
      }
    } catch (error) {
      print('getPlantes: Error occurred: $error');
      throw Exception('Erreur lors de la requête HTTP: $error');
    }
  }

  static Future<List<Plante>> getPlantesByUserId(int userId) async {
    print('getPlantesByUserId: Fetching plantes for user ID: $userId');
    try {
      var response = await _dio.get(
        Config.apiUrl + '/api/Plantes',
        options: Options(
          headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
        ),
      );

      print('getPlantesByUserId: Response received with status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        print('getPlantesByUserId: Response data: $data');

        final List<Map<String, dynamic>> jsonList = List<Map<String, dynamic>>.from(data);
        print('getPlantesByUserId: JSON list: $jsonList');

        var plantesList = jsonList.map((json) => Plante.fromJson(json)).toList();
        print('getPlantesByUserId: Parsed plantes list: $plantesList');

        var filteredPlantesList = plantesList.where((plante) {
          print('getPlantesByUserId: Checking plante idUtilisateur ${plante.idUtilisateur} against user ID $userId');
          return plante.idUtilisateur == userId;
        }).toList();
        print('getPlantesByUserId: Filtered plantes list for user ID $userId: $filteredPlantesList');

        return filteredPlantesList;
      } else {
        throw Exception('Échec de chargement des données: ${response.statusCode}');
      }
    } catch (error) {
      print('getPlantesByUserId: Error occurred: $error');
      throw Exception('Erreur lors de la requête HTTP: $error');
    }
  }
}
