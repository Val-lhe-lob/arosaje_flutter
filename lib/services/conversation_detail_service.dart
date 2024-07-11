import 'package:dio/dio.dart';
import '../models/conversation_model.dart' as conversation;
import '../models/message_detail_model.dart' as messageDetail;
import '../config.dart';

class ConversationDetailService {
  final Dio _dio = Dio();

  Future<List<messageDetail.MessageDetail>> getMessagesForConversation(int userId, int conversationUserId) async {
    print('Fetching messages for conversation between user: $userId and user: $conversationUserId');
    
    try {
      final response = await _dio.get('${Config.apiUrl}/api/EnvoyerRecevoirs/ConversationMessages/$userId/$conversationUserId');

      if (response.statusCode == 200) {
        print('Response received: ${response.data}');
        List<messageDetail.MessageDetail> messages = (response.data as List)
            .map((data) => messageDetail.MessageDetail.fromJson(data))
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
