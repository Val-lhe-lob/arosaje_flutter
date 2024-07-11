import 'package:arosaje_flutter/services/conversation_detail_service.dart';
import 'package:flutter/material.dart';
import 'package:arosaje_flutter/models/message_detail_model.dart';
import 'package:arosaje_flutter/services/message_service.dart';

class ConversationMessagesPage extends StatelessWidget {
  final int userId;
  final int conversationUserId;
  final ConversationDetailService _conversationDetailService = ConversationDetailService();

  ConversationMessagesPage({required this.userId, required this.conversationUserId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: FutureBuilder<List<MessageDetail>>(
        future: _conversationDetailService.getMessagesForConversation(userId, conversationUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load messages'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No messages found'));
          } else {
            final messages = snapshot.data!;
            return ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                bool isSentByUser = message.idUtilisateur == userId;
                return Align(
                  alignment: isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: isSentByUser ? Colors.green : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.contenu,
                          style: TextStyle(color: isSentByUser ? Colors.white : Colors.black),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          message.dateMessage.toLocal().toString(),
                          style: TextStyle(color: isSentByUser ? Colors.white70 : Colors.black54, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
