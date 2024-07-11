import 'package:arosaje_flutter/services/conversation_detail_service.dart';
import 'package:flutter/material.dart';
import 'package:arosaje_flutter/models/message_detail_model.dart';
import 'package:arosaje_flutter/services/message_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConversationMessagesPage extends StatefulWidget {
  final int userId;
  final int conversationUserId;

  ConversationMessagesPage({required this.userId, required this.conversationUserId});

  @override
  _ConversationMessagesPageState createState() => _ConversationMessagesPageState();
}

class _ConversationMessagesPageState extends State<ConversationMessagesPage> {
  final ConversationDetailService _conversationDetailService = ConversationDetailService();
  final MessagesService _messageService = MessagesService();
  final TextEditingController _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late Future<List<MessageDetail>> _messagesFuture;

  @override
  void initState() {
    super.initState();
    _fetchMessages();
  }

  void _fetchMessages() {
    setState(() {
      _messagesFuture = _conversationDetailService.getMessagesForConversation(widget.userId, widget.conversationUserId);
    });
  }

  Future<void> _sendMessage() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await MessagesService.sendMessage(
          widget.userId,
          widget.conversationUserId,
          _messageController.text,
        );
        _messageController.clear();
        _fetchMessages();
        Fluttertoast.showToast(
          msg: "Message envoyé",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } catch (error) {
        Fluttertoast.showToast(
          msg: "Failed to send message: $error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<MessageDetail>>(
              future: _messagesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Failed to load messages'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No messages found'));
                } else {
                  final messages = snapshot.data!;
                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      bool isSentByUser = message.idUtilisateur == widget.userId;
                      return Align(
                        alignment: isSentByUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: isSentByUser ? Colors.green : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message.contenu,
                                style: TextStyle(color: isSentByUser ? Colors.white : Colors.black),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                message.dateMessage.toLocal().toString(),
                                style: TextStyle(color: isSentByUser ? Colors.white70 : Colors.black54, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Enter your message',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a message';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 8.0),
                  ElevatedButton(
                    onPressed: _sendMessage,
                    child: Text('Send'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
