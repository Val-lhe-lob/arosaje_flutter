import 'package:arosaje_flutter/pages/conservation_message_page.dart';
import 'package:arosaje_flutter/services/conversation_service.dart';
import 'package:flutter/material.dart';
import 'package:arosaje_flutter/models/conversation_model.dart';

class ConversationsWidget extends StatefulWidget {
  final int userId;

  ConversationsWidget({required this.userId});

  @override
  _ConversationsWidgetState createState() => _ConversationsWidgetState();
}

class _ConversationsWidgetState extends State<ConversationsWidget> {
  final MessageService _messageService = MessageService();
  late Future<List<Conversation>> _conversationsFuture;

  @override
  void initState() {
    super.initState();
    _fetchConversations();
  }

  void _fetchConversations() {
    setState(() {
      _conversationsFuture = _messageService.getUserConversations(widget.userId);
    });
  }

  Future<void> _refreshConversations() async {
    _fetchConversations();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshConversations,
      child: FutureBuilder<List<Conversation>>(
        future: _conversationsFuture,
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
                            userId: widget.userId,
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
      ),
    );
  }
}
