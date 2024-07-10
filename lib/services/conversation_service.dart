import 'package:dio/dio.dart';
import '../models/conversation_model.dart' as conversation;
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
