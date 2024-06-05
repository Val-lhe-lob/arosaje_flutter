import 'dart:convert';
import 'package:arosaje_flutter/config.dart';
import 'package:arosaje_flutter/models/photo_model.dart';
import 'package:arosaje_flutter/services/photo_service.dart';
import 'package:arosaje_flutter/secure_local_storage_token.dart';
import 'package:http/http.dart' as http;

class InscriptionPlanteService {
  static Future<void> registerPlant(String name, String species, String description, String? base64Image, String? imageExtension, int cityId) async {
    List? tokenData = await TokenStorage().getToken();
    int? userId = tokenData?[2];
    String? token = tokenData?[0];

    if (userId == null || token == null) {
      throw Exception('User not logged in');
    }

    // Étape 1: Enregistrer l'image
    Map<String, dynamic> imageData = {
      'image': base64Image,
      'extension': imageExtension,
    };

    final responsePhoto = await http.post(
      Uri.parse('${Config.apiUrl}/api/photo'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(imageData),
    );

    if (responsePhoto.statusCode != 200) {
      throw Exception('Failed to register photo');
    }

    // Étape 2: Récupérer l'ID de la dernière photo
    final photoService = PhotoService(baseUrl: Config.apiUrl);
    final latestPhoto = await photoService.fetchLatestPhoto();
    final int photoId = latestPhoto.idPhoto;

    // Étape 3: Enregistrer la plante avec l'ID de la photo
    Map<String, dynamic> plantData = {
      'nom': name,
      'espece': species,
      'description': description,
      'idUtilisateur': userId,
      'idPhoto': photoId,
      'idVille': cityId,
    };

    final response = await http.post(
      Uri.parse('${Config.apiUrl}/api/plantes'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(plantData),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to register plant');
    }
  }

  static Future<List<Map<String, dynamic>>> fetchCities() async {
    final response = await http.get(
      Uri.parse('${Config.apiUrl}/api/villes'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load cities');
    }

    List<dynamic> body = jsonDecode(response.body);
    List<Map<String, dynamic>> cities = body.map((dynamic item) => {
          'id': item['id'],
          'name': item['name'],
        }).toList();
    return cities;
  }
}
