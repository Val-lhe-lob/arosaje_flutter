import 'package:arosaje_flutter/services/send_message_service.dart';
import 'package:flutter/material.dart';

class MessageForm extends StatefulWidget {
  final int senderId;
  final int receiverId;

  MessageForm({required this.senderId, required this.receiverId});

  @override
  _MessageFormState createState() => _MessageFormState();
}

class _MessageFormState extends State<MessageForm> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  final MessageService _messageService = MessageService();

  Future<void> _sendMessage() async {
    if (_formKey.currentState?.validate() ?? false) {
      bool success = await _messageService.sendMessage(
        widget.senderId,
        widget.receiverId,
        _messageController.text,
      );
      if (success) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Message sent successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send message')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _messageController,
            decoration: InputDecoration(labelText: 'Enter your message'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a message';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _sendMessage,
            child: Text('Send Message'),
          ),
        ],
      ),
    );
  }
}
