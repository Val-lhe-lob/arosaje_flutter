import 'package:dio/dio.dart';
import 'package:arosaje_flutter/config.dart';
import '../secure_local_storage_token.dart';

class MessageService {
  final TokenStorage _tokenStorage = TokenStorage();
  final Dio _dio = Dio();

  Future<bool> sendMessage(int senderId, int receiverId, String content) async {
    try {
      print('Retrieving token...');
      final token = await _tokenStorage.getToken();
      print('Token retrieved: $token');
      
      // Step 1: Insert the message into the Message table
      print('Sending message to the API...');
      final messageResponse = await _dio.post(
        Config.apiUrl + '/api/messages',
        data: {
          "contenu": content,
          "dateMessage": DateTime.now().toIso8601String(),
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      print('Message response status code: ${messageResponse.statusCode}');
      print('Message response data: ${messageResponse.data}');

      if (messageResponse.statusCode == 200 || messageResponse.statusCode == 201) {
        // Ensure the message ID is correctly extracted
        int messageId = messageResponse.data['idMessage'];
        print('Message ID: $messageId');

        // Step 2: Create an entry in the Envoyer_recevoir table
        print('Creating entry in Envoyer_recevoir table...');
        final envoyerRecevoirResponse = await _dio.post(
          Config.apiUrl + '/api/Envoyerrecevoirs/MessageSimple',
          data: {
            "IdUtilisateur": senderId,
            "IdUtilisateur1": senderId,
            "IdUtilisateur2": receiverId,
            "IdMessage": messageId,
          },
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ),
        );

        print('Envoyer_recevoir response status code: ${envoyerRecevoirResponse.statusCode}');
        print('Envoyer_recevoir response data: ${envoyerRecevoirResponse.data}');

        return envoyerRecevoirResponse.statusCode == 200 || envoyerRecevoirResponse.statusCode == 201;
      } else {
        print('Failed to send message. Status code: ${messageResponse.statusCode}');
        return false;
      }
    } on DioError catch (dioError) {
      // Enhanced error logging
      print('DioError during sending message: ${dioError.message}');
      if (dioError.response != null) {
        print('Response data: ${dioError.response?.data}');
        print('Response headers: ${dioError.response?.headers}');
        print('Response request: ${dioError.response?.requestOptions}');
      } else {
        print('Error type: ${dioError.type}');
        print('Error message: ${dioError.message}');
      }
      return false;
    } catch (e) {
      print('Exception during sending message: $e');
      return false;
    }
  }
}
