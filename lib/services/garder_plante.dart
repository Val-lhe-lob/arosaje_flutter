import 'package:dio/dio.dart';
import '../config.dart';

class GarderPlanteService {
  static Dio _dio = Dio()..interceptors.add(LogInterceptor(responseBody: true));

  static Future<bool> garderPlante(int planteId, int userId) async {
    try {
      var response = await _dio.put(
        '${Config.apiUrl}/api/Plantes/$planteId',
        options: Options(
          headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
        ),
        data: {
          'Id_Utilisateur_1': userId,
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Échec de mise à jour des données: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Erreur lors de la requête HTTP: $error');
    }
  }
}
