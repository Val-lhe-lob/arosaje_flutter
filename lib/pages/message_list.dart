import 'package:arosaje_flutter/models/message_model.dart' as message;
import 'package:arosaje_flutter/services/conversation_service.dart';
import 'package:arosaje_flutter/services/message_service.dart';
import 'package:flutter/material.dart';

class MessageList extends StatefulWidget {
  final int userId;
  final int conversationUserId;

  MessageList({required this.userId, required this.conversationUserId});

  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  late Future<List<message.Message>> futureMessages;
  final MessageService messageService = MessageService();

  @override
  void initState() {
    super.initState();
    futureMessages = messageService.getMessagesForConversation(widget.userId, widget.conversationUserId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<message.Message>>(
      future: futureMessages,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index].contenu),
                subtitle: Text(snapshot.data![index].dateMessage.toString()),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
