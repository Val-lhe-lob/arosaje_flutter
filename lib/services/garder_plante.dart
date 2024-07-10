import 'package:arosaje_flutter/models/plante_model.dart';
import 'package:dio/dio.dart';
import '../config.dart';

class GarderPlanteService {
  static Dio _dio = Dio()..interceptors.add(LogInterceptor(responseBody: true));

  static Future<bool> garderPlante(int planteId, int newUserId) async {
    try {
        
    

      var response = await _dio.put(
        '${Config.apiUrl}/api/Plantes/UpdateIdUtilisateur1/$planteId',
        options: Options(
          headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
        ),
        data: {
          
          'IdPlante': planteId,
          'IdUtilisateur1': newUserId,

        },
      );

  

     if (response.statusCode == 204) {
        return true;
      } else {
        throw Exception('Échec de mise à jour des données: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Erreur lors de la requête HTTP: $error');
    }
  }
}