import 'package:arosaje_flutter/pages/message_list.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {
  final int userId;
  final int conversationUserId;

  MessagePage({required this.userId, required this.conversationUserId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages with User $conversationUserId'),
      ),
      body: MessageList(userId: userId, conversationUserId: conversationUserId),
    );
  }
}
