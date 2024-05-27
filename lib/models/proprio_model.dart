import 'package:arosaje_flutter/models/utilisateur_model.dart';

class Proprio {
  final int idUtilisateur;
  final Utilisateur utilisateur;

  Proprio({
    required this.idUtilisateur,
    required this.utilisateur,
  });

  factory Proprio.fromJson(Map<String, dynamic> json) {
    return Proprio(
      idUtilisateur: json['Id_Utilisateur'],
      utilisateur: Utilisateur.fromJson(json['Utilisateur']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id_Utilisateur': idUtilisateur,
      'Utilisateur': utilisateur.toJson(),
    };
  }
}
