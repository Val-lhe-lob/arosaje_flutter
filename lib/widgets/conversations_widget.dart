import 'package:arosaje_flutter/pages/conservation_message_page.dart';
import 'package:arosaje_flutter/services/conversation_service.dart';
import 'package:flutter/material.dart';
import 'package:arosaje_flutter/models/conversation_model.dart';
import 'package:arosaje_flutter/services/message_service.dart';

class ConversationsWidget extends StatelessWidget {
  final int userId;
  final MessageService _messageService = MessageService();

  ConversationsWidget({required this.userId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Conversation>>(
      future: _messageService.getUserConversations(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Failed to load conversations'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No conversations found'));
        } else {
          final conversations = snapshot.data!;
          return ListView.builder(
            itemCount: conversations.length,
            itemBuilder: (context, index) {
              final conversation = conversations[index];
              return Container(
                margin: EdgeInsets.symmetric(vertical: 5.0),
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: Text('Conversation with ${conversation.userName}'),
                  subtitle: Text('Last Message: ${conversation.lastMessage.contenu}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ConversationMessagesPage(
                          userId: userId,
                          conversationUserId: conversation.userId,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}
