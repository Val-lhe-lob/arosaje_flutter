import 'package:dio/dio.dart';
import 'package:arosaje_flutter/config.dart';
import '../secure_local_storage_token.dart';

class MessageService {
  final TokenStorage _tokenStorage = TokenStorage();
  final Dio _dio = Dio();

  Future<bool> sendMessage(int senderId, int receiverId, String content) async {
    try {
      final token = await _tokenStorage.getToken();
      
      // Step 1: Insert the message into the Message table
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

      if (messageResponse.statusCode == 200) {
        int messageId = messageResponse.data['Id_Message'];

        // Step 2: Create an entry in the Envoyer_recevoir table
        final envoyerRecevoirResponse = await _dio.post(
          Config.apiUrl + '/api/Envoyerrecevoirs',
          data: {
            "Id_Utilisateur": senderId,
            "Id_Utilisateur_1": senderId,
            "Id_Utilisateur_2": receiverId,
            "Id_Message": messageId,
          },
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ),
        );

        return envoyerRecevoirResponse.statusCode == 200;
      } else {
        return false;
      }
    } catch (e) {
      print('Exception during sending message: $e');
      return false;
    }
  }
}
