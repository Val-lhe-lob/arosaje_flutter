import 'package:dio/dio.dart';
import 'package:arosaje_flutter/models/ville_model.dart';
import 'dart:convert';
import '../config.dart';

class VillesService {
  static Dio _dio = Dio();

  static Future<List<Ville>> getVilles() async {
    try {
      var response = await _dio.get(
        Config.apiUrl + 'api/Villes',
        options: Options(
          headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Ville.fromJson(json)).toList();
      } else {
        throw Exception('Échec de chargement des données');
      }
    } catch (error) {
      throw Exception('Erreur lors de la requête HTTP: $error');
    }
  }
}
