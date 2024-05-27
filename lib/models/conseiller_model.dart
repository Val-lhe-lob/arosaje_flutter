import 'package:arosaje_flutter/models/botaniste_model.dart';
import 'package:arosaje_flutter/models/tips_model.dart';

class Conseiller {
  final int idUtilisateur;
  final int idTips;
  final Botaniste botaniste;
  final Tips tips;

  Conseiller({
    required this.idUtilisateur,
    required this.idTips,
    required this.botaniste,
    required this.tips,
  });

  factory Conseiller.fromJson(Map<String, dynamic> json) {
    return Conseiller(
      idUtilisateur: json['Id_Utilisateur'],
      idTips: json['Id_Tips'],
      botaniste: Botaniste.fromJson(json['Botaniste']),
      tips: Tips.fromJson(json['Tips']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id_Utilisateur': idUtilisateur,
      'Id_Tips': idTips,
      'Botaniste': botaniste.toJson(),
      'Tips': tips.toJson(),
    };
  }
}
