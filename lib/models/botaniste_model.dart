import 'utilisateur_model.dart';

class Botaniste {
  final int idUtilisateur;
  final Utilisateur utilisateur;

  Botaniste({
    required this.idUtilisateur,
    required this.utilisateur,
  });

  factory Botaniste.fromJson(Map<String, dynamic> json) {
    return Botaniste(
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
