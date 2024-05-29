import 'utilisateur_model.dart';
import 'date_tips_model.dart';

class Conseiller {
  final int idUtilisateur;
  final int idTips;
  final Utilisateur utilisateur;
  final DateTips tips;

  Conseiller({
    required this.idUtilisateur,
    required this.idTips,
    required this.utilisateur,
    required this.tips,
  });

  factory Conseiller.fromJson(Map<String, dynamic> json) {
    return Conseiller(
      idUtilisateur: json['Id_Utilisateur'],
      idTips: json['Id_Tips'],
      utilisateur: Utilisateur.fromJson(json['Utilisateur']),
      tips: DateTips.fromJson(json['Tips']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id_Utilisateur': idUtilisateur,
      'Id_Tips': idTips,
      'Utilisateur': utilisateur.toJson(),
      'Tips': tips.toJson(),
    };
  }
}
