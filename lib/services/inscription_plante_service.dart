import 'dart:convert';
import 'package:arosaje_flutter/config.dart';
import 'package:arosaje_flutter/models/photo_model.dart';
import 'package:arosaje_flutter/models/ville_model.dart';
import 'package:arosaje_flutter/services/photo_service.dart';
import 'package:arosaje_flutter/secure_local_storage_token.dart';
import 'package:http/http.dart' as http;

class InscriptionPlanteService {
  static Future<void> registerPlant(String name, String species, String description, String? base64Image, String? imageExtension, int cityId) async {
    List? tokenData = await TokenStorage().getToken();
    String? token = tokenData?[0];
    String? email = tokenData?[1];
    String? userIdString = tokenData?[2];
    int? userId = userIdString != null ? int.parse(userIdString) : null;


    print('Token: $token'); // Ligne de débogage
    print('Email: $email'); // Ligne de débogage
    print('User ID: $userId'); // Ligne de débogage

    if (userId == null || token == null) {
      throw Exception('User not logged in');
    }

    
    // Étape 1: Enregistrer l'image
    Map<String, dynamic> imageData = {
      'image': base64Image,
      'extension': imageExtension,
    };

    final responsePhoto = await http.post(
      Uri.parse('${Config.apiUrl}/api/photos'), // Assurez-vous que cette URL est correcte
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(imageData),
    );

    if (responsePhoto.statusCode != 201) {
      throw Exception('Failed to register photo');
    }

    // Étape 2: Récupérer l'ID de la dernière photo
    final photoService = PhotoService(baseUrl: Config.apiUrl);
    final latestPhoto = await photoService.fetchLatestPhoto();
    final int? photoId = latestPhoto.idPhoto;

    if (photoId == null) {
      throw Exception('Failed to retrieve photo ID');
    }

    print('Latest photo ID: $photoId'); // Ligne de débogage

    // Étape 3: Enregistrer la plante avec l'ID de la photo
    Map<String, dynamic> plantData = {
      'nom': name,
      'espece': species,
      'description': description,
      'idVille': cityId,
      'lon': '0.0',  // Utilisez une valeur par défaut si nécessaire
      'lat': '0.0',  // Utilisez une valeur par défaut si nécessaire
      'idPhoto': photoId,
      'idUtilisateur': userId.toInt(),
      'idUtilisateur1': 0
    };

    print('Sending plant data: $plantData'); // Ligne de débogage

    final response = await http.post(
      Uri.parse('${Config.apiUrl}/api/plantes'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(plantData),
    );

    print('Plant registration response: ${response.statusCode}'); // Ligne de débogage
    print('Plant registration response body: ${response.body}'); // Ligne de débogage

    if (response.statusCode != 201) {
      throw Exception('Failed to register plant');
    }
  }

  static Future<List<Ville>> fetchCities() async {
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
    List<Ville> cities = body.map((dynamic item) => Ville.fromJson(item)).toList();
    return cities;
  }
}
