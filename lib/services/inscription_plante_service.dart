import 'dart:convert';
import 'package:arosaje_flutter/config.dart';
import 'package:arosaje_flutter/models/ville_model.dart';
import 'package:arosaje_flutter/secure_local_storage_token.dart';
import 'package:dio/dio.dart';
import 'package:arosaje_flutter/services/photo_service.dart'; // Importez le PhotoService

class InscriptionPlanteService {
  static Dio _dio = Dio();

  static Future<void> registerPlant(
      String name,
      String species,
      String description,
      String? base64Image,
      String? imageExtension,
      int cityId,
      String category,
      String lat,
      String lon,
  ) async {
    try {
      List? tokenData = await TokenStorage().getToken();
      String? token = tokenData?[0];
      String? userIdString = tokenData?[2];
      int? userId = userIdString != null ? int.parse(userIdString) : null;

      if (userId == null || token == null) {
        throw Exception('User not logged in');
      }

      int photoId = 0; // Default photo ID if no image is provided
      if (base64Image != null && imageExtension != null) {
        Map<String, dynamic> imageData = {
          'image': base64Image,
          'extension': imageExtension,
        };

        final responsePhoto = await _dio.post(
          '${Config.apiUrl}/api/photos',
          data: jsonEncode(imageData),
          options: Options(
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token',
            },
          ),
        );

        if (responsePhoto.statusCode == 201) {
          // Fetch the latest photo ID
          final PhotoService photoService = PhotoService();
          final latestPhoto = await photoService.fetchLatestPhoto();
          photoId = latestPhoto.idPhoto;
        } else {
          throw Exception('Échec de l\'enregistrement de la photo. Code: ${responsePhoto.statusCode}');
        }
      }

      final response = await _dio.post(
        '${Config.apiUrl}/api/plantes',
        data: {
          'espece': species,
          'nom': name,
          'description': description,
          'categorie': category,
          'etat': 'Good',
          'lon': lon,
          'lat': lat,
          'idVille': cityId,
          'idPhoto': photoId,
          'idUtilisateur': userId,
          'idUtilisateur1': userId,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 201) {
        print('Enregistrement de la plante réussi.');
      } else {
        throw Exception('Échec de l\'enregistrement de la plante. Code: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioError) {
        print('DioError type: ${e.type}');
        print('DioError message: ${e.message}');
        print('DioError response: ${e.response?.data}');
      } else {
        print('Exception lors de l\'inscription de la plante: $e');
      }
      throw e;
    }
  }

  static Future<List<Ville>> fetchCities() async {
    try {
      final response = await _dio.get(
        '${Config.apiUrl}/api/villes',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> body = response.data;
        List<Ville> cities = body.map((dynamic item) => Ville.fromJson(item)).toList();
        return cities;
      } else {
        throw Exception('Failed to load cities. Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception while fetching cities: $e');
      throw e;
    }
  }
}
