import 'plante_model.dart';

class Ville {
  final int idVille;
  final String nom;
  final String desc;
  List<Plante>? plantes;

  Ville({
    required this.idVille,
    required this.nom,
    required this.desc,
    this.plantes,
  });

  factory Ville.fromJson(Map<String, dynamic> json) {
    return Ville(
      idVille: json['Id_Ville'],
      nom: json['Nom'],
      desc: json['Desc'],
      plantes: json['Plantes'] != null
          ? (json['Plantes'] as List).map((item) => Plante.fromJson(item)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id_Ville': idVille,
      'Nom': nom,
      'Desc': desc,
      'Plantes': plantes?.map((plante) => plante.toJson()).toList(),
    };
  }
}
