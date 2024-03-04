class Ville {
  final int idVille;
  final String nom;
  final String desc;
  final List<dynamic> plantes;
  final List<dynamic> idUtilisateurs;

  Ville({
    required this.idVille,
    required this.nom,
    required this.desc,
    required this.plantes,
    required this.idUtilisateurs,
  });

  factory Ville.fromJson(Map<String, dynamic> json) {
    return Ville(
      idVille: json['idVille'],
      nom: json['nom'],
      desc: json['desc'],
      plantes: json['plantes'],
      idUtilisateurs: json['idUtilisateurs'],
    );
  }
}
