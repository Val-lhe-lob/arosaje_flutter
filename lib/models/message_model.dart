class Message {
  final int idMessage;
  final String contenu;
  final DateTime dateMessage;
  final List<dynamic> envoyerRecevoirs;

  Message({
    required this.idMessage,
    required this.contenu,
    required this.dateMessage,
    required this.envoyerRecevoirs,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      idMessage: json['idMessage'] as int,
      contenu: json['contenu'] as String,
      dateMessage: DateTime.parse(json['dateMessage'] as String),
      envoyerRecevoirs: json['envoyerRecevoirs'] as List<dynamic>,
    );
  }
}
