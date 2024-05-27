import 'package:arosaje_flutter/models/plante_model.dart';
import 'package:arosaje_flutter/models/tips_model.dart';

class HasTips {
  final int idPlante;
  final int idTips;
  final Plante plante;
  final Tips tips;

  HasTips({
    required this.idPlante,
    required this.idTips,
    required this.plante,
    required this.tips,
  });

  factory HasTips.fromJson(Map<String, dynamic> json) {
    return HasTips(
      idPlante: json['Id_Plante'],
      idTips: json['Id_Tips'],
      plante: Plante.fromJson(json['Plante']),
      tips: Tips.fromJson(json['Tips']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id_Plante': idPlante,
      'Id_Tips': idTips,
      'Plante': plante.toJson(),
      'Tips': tips.toJson(),
    };
  }
}
