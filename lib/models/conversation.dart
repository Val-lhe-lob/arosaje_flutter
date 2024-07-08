class Conversation {
  final int userId;
  final Message lastMessage;

  Conversation({required this.userId, required this.lastMessage});

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      userId: json['userId'],
      lastMessage: Message.fromJson(json['lastMessage']),
    );
  }
}

class Message {
  final int id;
  final String content;
  final DateTime date;

  Message({required this.id, required this.content, required this.date});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['idMessage'],
      content: json['contenu'],
      date: DateTime.parse(json['dateMessage']),
    );
  }
}
