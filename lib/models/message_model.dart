class Message {
  final int idMessage;
  final String contenu;
  final String dateMessage;

  Message({
    required this.idMessage,
    required this.contenu,
    required this.dateMessage,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      idMessage: json['Id_Message'],
      contenu: json['Contenu'],
      dateMessage: json['DateMessage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id_Message': idMessage,
      'Contenu': contenu,
      'DateMessage': dateMessage,
    };
  }
}
