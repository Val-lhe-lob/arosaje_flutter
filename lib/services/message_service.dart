import 'package:arosaje_flutter/models/message_detail_model.dart';
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

  static Future<void> sendLastMessage(int idUtilisateur, int idUtilisateur1) async {
    try {
      print('Fetching last message...');
      var lastMessage = await getLastMessage();
      print('Last message fetched: ${lastMessage.toJson()}');

      if (lastMessage.idMessage == null) {
        throw Exception('Last message ID is null');
      }

      var envoyerRecevoirDto = {
        'IdUtilisateur': idUtilisateur,
        'IdUtilisateur1': idUtilisateur1,
        'IdMessage': lastMessage.idMessage
      };

      print('Sending request to: ${Config.apiUrl}/api/EnvoyerRecevoirs/MessageSimple with data: $envoyerRecevoirDto');
      envoyerRecevoirDto.forEach((key, value) {
        print('Key: $key, Value: $value');
      });

      var response = await _dio.post(
        '${Config.apiUrl}/api/EnvoyerRecevoirs/MessageSimple',
        data: {
          'IdUtilisateur': idUtilisateur,
          'IdUtilisateur1': idUtilisateur1,
          'IdMessage': lastMessage.idMessage
        }
      );

      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode != 201) {
        throw Exception('Échec de l\'envoi du dernier message');
      }
    } catch (error) {
      print('Error occurred in sendLastMessage:');
      if (error is DioError) {
        print('Erreur lors de la requête HTTP: ${error.response?.data}');
        throw Exception('Erreur lors de la requête HTTP: ${error.response?.data}');
      } else {
        print('Erreur lors de la requête HTTP: $error');
        throw Exception('Erreur lors de la requête HTTP: $error');
      }
    }
  }

  static Future<void> sendMessage(int senderId, int receiverId, String content) async {
    try {
      // Create the message
      var newMessage = {
        'Contenu': content,
        'DateMessage': DateTime.now().toIso8601String()
      };

      print('Sending request to: ${Config.apiUrl}/api/Messages with data: $newMessage');
      var response = await _dio.post(
        '${Config.apiUrl}/api/Messages',
        data: newMessage,
      );

      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 201) {
        var createdMessage = Message.fromJson(response.data);
        print('Created message: ${createdMessage.toJson()}');

        if (createdMessage.idMessage == null) {
          throw Exception('Created message ID is null');
        }

        var envoyerRecevoirDto = {
          'IdUtilisateur': senderId,
          'IdUtilisateur1': receiverId,
          'IdMessage': createdMessage.idMessage
        };

        print('Sending request to: ${Config.apiUrl}/api/EnvoyerRecevoirs/MessageSimple with data: $envoyerRecevoirDto');
        envoyerRecevoirDto.forEach((key, value) {
          print('Key: $key, Value: $value');
        });

        var responseEnvoyerRecevoir = await _dio.post(
          '${Config.apiUrl}/api/EnvoyerRecevoirs/MessageSimple',
          data: envoyerRecevoirDto,
        );

        print('Response status code: ${responseEnvoyerRecevoir.statusCode}');
        print('Response data: ${responseEnvoyerRecevoir.data}');

        if (responseEnvoyerRecevoir.statusCode != 201) {
          throw Exception('Failed to link message with users');
        }
      } else {
        throw Exception('Failed to create message');
      }
    } catch (error) {
      print('Error occurred in sendMessage:');
      if (error is DioError) {
        print('HTTP request error: ${error.response?.data}');
        throw Exception('HTTP request error: ${error.response?.data}');
      } else {
        print('HTTP request error: $error');
        throw Exception('HTTP request error: $error');
      }
    }
  }
}