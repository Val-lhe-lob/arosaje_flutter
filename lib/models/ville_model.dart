class Ville {
  final int idVille;
  final String nom;
  final String desc;

  Ville({
    required this.idVille,
    required this.nom,
    required this.desc,
  });

  factory Ville.fromJson(Map<String, dynamic> json) {
    return Ville(
      idVille: json['Id_Ville'],
      nom: json['Nom'],
      desc: json['Desc'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id_Ville': idVille,
      'Nom': nom,
      'Desc': desc,
    };
  }
}
