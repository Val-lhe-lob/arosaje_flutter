import 'package:arosaje_flutter/models/plante_model.dart';

class Ville {
  final int idVille;
  final String nom;
  final String desc;
  List<Plante>? plantes; // Plantes associées à la ville

  Ville({
    required this.idVille,
    required this.nom,
    required this.desc,
    this.plantes,
  });

  factory Ville.fromJson(Map<String, dynamic> json) {
    return Ville(
      idVille: json['idVille'] ?? 0,
      nom: json['nom'] ?? '',
      desc: json['desc'] ?? '',
      plantes: json['plantes'] != null
          ? (json['plantes'] as List).map((i) => Plante.fromJson(i)).toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idVille': idVille,
      'nom': nom,
      'desc': desc,
      'plantes': plantes?.map((e) => e.toJson()).toList(),
    };
  }
}
