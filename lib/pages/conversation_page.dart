import 'package:arosaje_flutter/widgets/conversation_widget.dart';
import 'package:flutter/material.dart';

class ConversationsPage extends StatelessWidget {
  final int userId;

  ConversationsPage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversations'),
      ),
      body: ConversationsWidget(userId: userId),
    );
  }
}
