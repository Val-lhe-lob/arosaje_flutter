import 'utilisateur_model.dart';
import 'ville_model.dart';

class Habite {
  final int idUtilisateur;
  final int idVille;
  final Utilisateur utilisateur;
  final Ville ville;

  Habite({
    required this.idUtilisateur,
    required this.idVille,
    required this.utilisateur,
    required this.ville,
  });

  factory Habite.fromJson(Map<String, dynamic> json) {
    return Habite(
      idUtilisateur: json['Id_Utilisateur'],
      idVille: json['Id_Ville'],
      utilisateur: Utilisateur.fromJson(json['Utilisateur']),
      ville: Ville.fromJson(json['Ville']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id_Utilisateur': idUtilisateur,
      'Id_Ville': idVille,
      'Utilisateur': utilisateur.toJson(),
      'Ville': ville.toJson(),
    };
  }
}
