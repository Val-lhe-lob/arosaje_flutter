class Plante {
  final int idPlante;
  final String nom;
  final String desc;
  final List<dynamic> ville;
  final List<dynamic> idUtilisateurs;

  Plante({
    required this.idPlante,
    required this.nom,
    required this.desc,
    required this.ville,
    required this.idUtilisateurs,
  });

  factory Plante.fromJson(Map<String, dynamic> json) {
    return Plante(
      idPlante: json['idPlante'],
      nom: json['nom'],
      desc: json['desc'],
      ville: json['ville'],
      idUtilisateurs: json['idUtilisateurs'],
    );
  }
}
