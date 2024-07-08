import 'package:flutter/material.dart';
import '../widgets/conversation_list_widget.dart';

class ConversationPage extends StatelessWidget {
  final int userId;

  ConversationPage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversations'),
      ),
      body: ConversationList(userId: userId),
    );
  }
}
