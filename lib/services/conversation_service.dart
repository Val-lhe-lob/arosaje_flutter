import 'package:dio/dio.dart';
import '../models/conversation.dart' as conversation;
import '../models/message_model.dart' as message;
import '../config.dart';

class MessageService {
  final Dio _dio = Dio();

  Future<List<conversation.Conversation>> getUserConversations(int userId) async {
    print('Fetching conversations for user: $userId');

    try {
      final response = await _dio.get('${Config.apiUrl}/api/EnvoyerRecevoirs/Conversations/$userId');

      if (response.statusCode == 200) {
        print('Response received: ${response.data}');
        List<conversation.Conversation> conversations = (response.data as List)
            .map((data) => conversation.Conversation.fromJson(data))
            .toList();
        print('Conversations parsed successfully');
        return conversations;
      } else {
        print('Failed to load conversations, status code: ${response.statusCode}');
        print('Response data: ${response.data}');
        return [];
      }
    } catch (e) {
      if (e is DioError) {
        print('DioError occurred: ${e.message}');
        if (e.response != null) {
          print('Response status code: ${e.response!.statusCode}');
          print('Response data: ${e.response!.data}');
        }
      } else {
        print('Exception occurred: $e');
      }
      throw Exception('Failed to load conversations');
    }
  }

  Future<void> sendLastMessage(int idUtilisateur1, int idUtilisateur2, int idMessage) async {
    try {
      print('Sending request to: ${Config.apiUrl}/api/EnvoyerRecevoirs/MessageSimple with parameters: idUtilisateur1=$idUtilisateur1, idUtilisateur2=$idUtilisateur2, idMessage=$idMessage');
      var response = await _dio.post(
        '${Config.apiUrl}/api/EnvoyerRecevoirs/MessageSimple',
        data: {
          'idUtilisateur': idUtilisateur1,
          'idUtilisateur1': idUtilisateur1,
          'idUtilisateur2': idUtilisateur2,
          'idMessage': idMessage,
        },
      );
      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode != 201) {
        throw Exception('Échec de l\'envoi du message');
      }
    } catch (error) {
      print('Erreur lors de la requête HTTP: $error');
      throw Exception('Erreur lors de la requête HTTP: $error');
    }
  }

  Future<List<message.Message>> getMessagesForConversation(int userId, int conversationUserId) async {
    print('Fetching messages for conversation between user: $userId and user: $conversationUserId');
    
    try {
      final response = await _dio.get('${Config.apiUrl}/api/EnvoyerRecevoirs/ConversationMessages/$userId/$conversationUserId');

      if (response.statusCode == 200) {
        print('Response received: ${response.data}');
        List<message.Message> messages = (response.data as List)
            .map((data) => message.Message.fromJson(data))
            .toList();
        print('Messages parsed successfully');
        return messages;
      } else {
        print('Failed to load messages, status code: ${response.statusCode}');
        print('Response data: ${response.data}');
        return [];
      }
    } catch (e) {
      if (e is DioError) {
        print('DioError occurred: ${e.message}');
        if (e.response != null) {
          print('Response status code: ${e.response!.statusCode}');
          print('Response data: ${e.response!.data}');
        }
      } else {
        print('Exception occurred: $e');
      }
      throw Exception('Failed to load messages');
    }
  }
}
