class Message {
  final int idMessage;
  final String contenu;
  final DateTime dateMessage;

  Message({
    required this.idMessage,
    required this.contenu,
    required this.dateMessage,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      idMessage: json['Id_Message'],
      contenu: json['contenu'],
      dateMessage: DateTime.parse(json['dateMessage']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id_Message': idMessage,
      'contenu': contenu,
      'dateMessage': dateMessage.toIso8601String(),
    };
  }
}
