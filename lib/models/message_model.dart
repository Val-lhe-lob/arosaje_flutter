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
      idMessage: json['idMessage'],
      contenu: json['contenu'],
      dateMessage: DateTime.parse(json['dateMessage']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idMessage': idMessage,
      'contenu': contenu,
      'dateMessage': dateMessage.toIso8601String(),
    };
  }
}
