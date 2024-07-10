class Conversation {
  final int userId;
  final int idUtilisateur;
  final int idUtilisateur1;
  final LastMessage lastMessage;

  Conversation({
    required this.userId,
    required this.idUtilisateur,
    required this.idUtilisateur1,
    required this.lastMessage,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      userId: json['userId'] ?? 0,
      idUtilisateur: json['idUtilisateur'] ?? 0,
      idUtilisateur1: json['idUtilisateur1'] ?? 0,
      lastMessage: LastMessage.fromJson(json['lastMessage']),
    );
  }
}

class LastMessage {
  final int idMessage;

  LastMessage({required this.idMessage});

  factory LastMessage.fromJson(Map<String, dynamic> json) {
    return LastMessage(
      idMessage: json['idMessage'] ?? 0,
    );
  }
}
