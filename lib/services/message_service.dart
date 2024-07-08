import 'package:dio/dio.dart';
import 'package:arosaje_flutter/models/message_model.dart';
import '../config.dart';

class MessagesService {
  static final Dio _dio = Dio();

  static Future<List<Message>> getMessages() async {
    try {
      print('Sending request to: ${Config.apiUrl}/api/Messages/Simple');
      var response = await _dio.get('${Config.apiUrl}/api/Messages/Simple');
      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => Message.fromJson(json)).toList();
      } else {
        throw Exception('Échec de chargement des données');
      }
    } catch (error) {
      print('Erreur lors de la requête HTTP: $error');
      throw Exception('Erreur lors de la requête HTTP: $error');
    }
  }

  static Future<Message> getLastMessage() async {
    try {
      print('Sending request to: ${Config.apiUrl}/api/Messages/Last');
      var response = await _dio.get('${Config.apiUrl}/api/Messages/Last');
      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        return Message.fromJson(response.data);
      } else {
        throw Exception('Échec de chargement du dernier message');
      }
    } catch (error) {
      print('Erreur lors de la requête HTTP: $error');
      throw Exception('Erreur lors de la requête HTTP: $error');
    }
  }

  static Future<void> sendLastMessage(int idUtilisateur1, int idUtilisateur2) async {
    try {
      print('Fetching last message...');
      var lastMessage = await getLastMessage();
      print('Last message fetched: ${lastMessage.toJson()}');

      print('Sending request to: ${Config.apiUrl}/api/EnvoyerRecevoirs/MessageSimple with parameters: idUtilisateur1=$idUtilisateur1, idUtilisateur2=$idUtilisateur2');
      var response = await _dio.post(
        '${Config.apiUrl}/api/EnvoyerRecevoirs/MessageSimple',
        queryParameters: {
          'idUtilisateur1': idUtilisateur1,
          'idUtilisateur2': idUtilisateur2,
        },
        data: lastMessage.toJson(),
      );
      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode != 201) {
        throw Exception('Échec de l\'envoi du dernier message');
      }
    } catch (error) {
      print('Erreur lors de la requête HTTP: $error');
      throw Exception('Erreur lors de la requête HTTP: $error');
    }
  }
}
