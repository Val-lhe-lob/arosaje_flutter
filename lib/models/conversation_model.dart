class Conversation {
  final int userId;
  final LastMessage lastMessage;

  Conversation({required this.userId, required this.lastMessage});

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      userId: json['userId'],
      lastMessage: LastMessage.fromJson(json['lastMessage']),
    );
  }
}

class LastMessage {
  final int idMessage;

  LastMessage({required this.idMessage});

  factory LastMessage.fromJson(Map<String, dynamic> json) {
    return LastMessage(
      idMessage: json['idMessage'],
    );
  }
}
