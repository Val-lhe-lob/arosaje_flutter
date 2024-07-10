import 'package:arosaje_flutter/services/conversation_service.dart';
import 'package:flutter/material.dart';
import 'package:arosaje_flutter/services/message_service.dart';
import 'package:arosaje_flutter/models/message_model.dart';

class ConversationMessagesPage extends StatelessWidget {
  final int userId;
  final int conversationUserId;
  final MessageService _messageService = MessageService();

  ConversationMessagesPage({
    required this.userId,
    required this.conversationUserId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages with User $conversationUserId'),
      ),
      body: FutureBuilder<List<Message>>(
        future: _messageService.getMessagesForConversation(userId, conversationUserId),
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
                return ListTile(
                  title: Text(message.contenu),
                  subtitle: Text(message.dateMessage.toString()),
                  leading: message.idUtilisateur == userId ? Icon(Icons.send) : Icon(Icons.not_accessible ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
