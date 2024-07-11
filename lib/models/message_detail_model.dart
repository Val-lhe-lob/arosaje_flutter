class MessageDetail {
  final int idMessage;
  final int idUtilisateur;
  final int idUtilisateur1;
  final String contenu;
  final DateTime dateMessage;

  MessageDetail({
    required this.idMessage,
    required this.idUtilisateur,
    required this.idUtilisateur1,
    required this.contenu,
    required this.dateMessage,
  });

  factory MessageDetail.fromJson(Map<String, dynamic> json) {
    return MessageDetail(
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
