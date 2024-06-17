import 'package:dio/dio.dart';
import 'package:arosaje_flutter/models/message_model.dart';
import '../config.dart';

class MessagesService {
  static Dio _dio = Dio();

  static Future<List<Message>> getMessages() async {
    try {
      var response = await _dio.get(
        Config.apiUrl + "/api/Messages",
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Message.fromJson(json)).toList();
      } else {
        throw Exception('Échec de chargement des données');
      }
    } catch (error) {
      throw Exception('Erreur lors de la requête HTTP: $error');
    }
  }
}
