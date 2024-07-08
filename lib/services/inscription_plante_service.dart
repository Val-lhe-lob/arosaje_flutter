import 'dart:convert';
import 'package:arosaje_flutter/config.dart';
import 'package:arosaje_flutter/models/ville_model.dart';
import 'package:arosaje_flutter/secure_local_storage_token.dart';
import 'package:dio/dio.dart';

class InscriptionPlanteService {
  static Dio _dio = Dio(); // Créez une instance Dio

  static Future<void> registerPlant(String name, String species, String description, String? base64Image, String? imageExtension, int cityId) async {
    try {
      List? tokenData = await TokenStorage().getToken();
      String? token = tokenData?[0];
      String? email = tokenData?[1];
      String? userIdString = tokenData?[2];
      int? userId = userIdString != null ? int.parse(userIdString) : null;

      if (userId == null || token == null) {
        throw Exception('User not logged in');
      }

      // Étape 1: Enregistrer l'image
      int? photoId;
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
          photoId = responsePhoto.data['id']; // Assurez-vous que votre API retourne l'ID de la photo correctement
          print('Photo enregistrée avec ID: $photoId');
        } else {
          throw Exception('Échec de l\'enregistrement de la photo. Code: ${responsePhoto.statusCode}');
        }
      }

      print('Sending plant data: ');
      print('Species: $species');
      print('Name: $name');
      print('Description: $description');

      // Étape 2: Enregistrer la plante
      final response = await _dio.post(
        Config.apiUrl + '/api/plantes',
        data: {
          'espece': species,
          'nom': name,
          'description': description,
          'categorie': 'Indoor', // Ajoutez une catégorie si nécessaire
          'etat': 'Good', // Ajoutez un état si nécessaire
          'lon': "0.0", // Valeur par défaut pour la longitude
          'lat': "test", // Valeur par défaut pour la latitude
          'idVille': cityId,
          'idPhoto': photoId ?? 1, // Utilisation d'une valeur par défaut pour l'ID de la photo si non disponible
          'idUtilisateur': 1,
          'idUtilisateur1': 1, // Assurez-vous que cela correspond à votre logique de données
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print('Plant registration response: ${response.statusCode}'); // Ligne de débogage
      print('Plant registration response body: ${response.data}'); // Ligne de débogage

      if (response.statusCode == 201) {
        print('Enregistrement de la plante réussi.');
      } else {
        throw Exception('Échec de l\'enregistrement de la plante. Code: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioError) {
        print('Exception lors de l\'inscription de la plante: ${e.response?.statusCode}');
        print('DioError response data: ${e.response?.data}');
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
