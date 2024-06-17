import 'utilisateur_model.dart';

class Membre {
  final int idUtilisateur;
  final Utilisateur utilisateur;

  Membre({
    required this.idUtilisateur,
    required this.utilisateur,
  });

  factory Membre.fromJson(Map<String, dynamic> json) {
    return Membre(
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
