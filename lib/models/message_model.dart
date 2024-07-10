class Message {
  final int idMessage;
  final int idUtilisateur;
  final int idUtilisateur1;
  final String contenu;
  final DateTime dateMessage;

  Message({
    required this.idMessage,
    required this.idUtilisateur,
    required this.idUtilisateur1,
    required this.contenu,
    required this.dateMessage,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      idMessage: json['idMessage'],
      idUtilisateur: json['idUtilisateur'],
      idUtilisateur1: json['idUtilisateur1'],
      contenu: json['contenu'],
      dateMessage: DateTime.parse(json['dateMessage']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idMessage': idMessage,
      'idUtilisateur': idUtilisateur,
      'idUtilisateur1': idUtilisateur1,
      'contenu': contenu,
      'dateMessage': dateMessage.toIso8601String(),
    };
  }
}
