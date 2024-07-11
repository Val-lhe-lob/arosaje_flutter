class Conversation {
  final int userId;
  final String userName;
  final LastMessage lastMessage;

  Conversation({required this.userId, required this.userName, required this.lastMessage});

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      userId: json['userId'],
      userName: json['userName'],
      lastMessage: LastMessage.fromJson(json['lastMessage']),
    );
  }
}

class LastMessage {
  final int idMessage;
  final String contenu;

  LastMessage({required this.idMessage, required this.contenu});

  factory LastMessage.fromJson(Map<String, dynamic> json) {
    return LastMessage(
      idMessage: json['idMessage'],
      contenu: json['contenu'],
    );
  }
}
