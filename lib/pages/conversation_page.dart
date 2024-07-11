import 'package:arosaje_flutter/widgets/conversations_widget.dart';
import 'package:flutter/material.dart';

class ConversationsPage extends StatelessWidget {
  final int userId;

  ConversationsPage({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conversations'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Logic to refresh the conversations
              Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) => ConversationsPage(userId: userId),
                  transitionDuration: Duration.zero,
                ),
              );
            },
          ),
        ],
      ),
      body: ConversationsWidget(userId: userId),
    );
  }
}
