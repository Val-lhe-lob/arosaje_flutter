import 'package:arosaje_flutter/models/message_model.dart';


class EnvoyerRecevoir {
  final int idUtilisateur;
  final int idUtilisateur1;
  final int idUtilisateur2;
  final int idMessage;
  final Message message;

  EnvoyerRecevoir({
    required this.idUtilisateur,
    required this.idUtilisateur1,
    required this.idUtilisateur2,
    required this.idMessage,
    required this.message,
  });

  factory EnvoyerRecevoir.fromJson(Map<String, dynamic> json) {
    return EnvoyerRecevoir(
      idUtilisateur: json['Id_Utilisateur'],
      idUtilisateur1: json['Id_Utilisateur_1'],
      idUtilisateur2: json['Id_Utilisateur_2'],
      idMessage: json['Id_Message'],
      message: Message.fromJson(json['Message']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id_Utilisateur': idUtilisateur,
      'Id_Utilisateur_1': idUtilisateur1,
      'Id_Utilisateur_2': idUtilisateur2,
      'Id_Message': idMessage,
      'Message': message.toJson(),
    };
  }
}
