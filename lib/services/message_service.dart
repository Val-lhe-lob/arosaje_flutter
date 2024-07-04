import 'package:dio/dio.dart';
import 'package:arosaje_flutter/models/message_model.dart';
import '../config.dart';

class MessagesService {
  static Dio _dio = Dio();

  static Future<List<Message>> getMessages() async {
    try {
      var response = await _dio.get(
        Config.apiUrl + "/api/Messages/Simple",
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

  static Future<Message> getLastMessage() async {
    try {
      var response = await _dio.get(
        Config.apiUrl + "/api/Messages/Last",
      );

      if (response.statusCode == 200) {
        return Message.fromJson(response.data);
      } else {
        throw Exception('Échec de chargement du dernier message');
      }
    } catch (error) {
      throw Exception('Erreur lors de la requête HTTP: $error');
    }
  }

  static Future<void> sendLastMessage(int idUtilisateur1, int idUtilisateur2) async {
    try {
      var lastMessage = await getLastMessage();

      var response = await _dio.post(
        Config.apiUrl + "/api/EnvoyerRecevoirs/MessageSimple",
        queryParameters: {
          'idUtilisateur1': idUtilisateur1,
          'idUtilisateur2': idUtilisateur2,
        }
      );

      if (response.statusCode != 201) {
        throw Exception('Échec de l\'envoi du dernier message');
      }
    } catch (error) {
      throw Exception('Erreur lors de la requête HTTP: $error');
    }
  }
}
