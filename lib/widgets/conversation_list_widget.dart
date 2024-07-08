import 'package:arosaje_flutter/services/conversation_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/message_service.dart';
import '../models/conversation.dart';
import '../pages/connexion_page.dart';
import '../pages/message_page.dart';

class ConversationList extends StatefulWidget {
  final int userId;

  ConversationList({required this.userId});

  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  late Future<List<Conversation>> futureConversations;
  final MessageService messageService = MessageService();

  @override
  void initState() {
    super.initState();
    futureConversations = messageService.getUserConversations(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Conversation>>(
      future: futureConversations,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No conversations found'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('User ${snapshot.data![index].userId}'),
                subtitle: Text(snapshot.data![index].lastMessage.content),
                onTap: () {
                  if (widget.userId == 0) {
                    Fluttertoast.showToast(
                      msg: "Vous devez vous connecter pour accéder aux messages",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ConnexionPage()),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MessagePage(
                          userId: widget.userId,
                          conversationUserId: snapshot.data![index].userId,
                        ),
                      ),
                    );
                  }
                },
              );
            },
          );
        }
      },
    );
  }
}
