import 'package:flutter/material.dart';
import 'package:arosaje_flutter/services/message_service.dart';
import 'package:arosaje_flutter/models/message_model.dart';

class MessagesListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Message>>(
      future: MessagesService.getMessages(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else {
          final Messages = snapshot.data!;
          return ListView.builder(
            itemCount: Messages.length,
            itemBuilder: (context, index) {
              final Message = Messages[index];
              return Container(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(130,174,137,1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: Text(Message.contenu),
                  subtitle: Text(Message.dateMessage.toString()),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // faire la logique
                    },
                    child: Text('Détail'),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
