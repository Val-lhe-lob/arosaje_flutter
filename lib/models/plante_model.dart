class Plante {
  final int idPlante;
  final String? espece;
  final String? description;
  final String? categorie;
  final String? etat;
  final String? nom;
  final int? lon;
  final int? lat;
  final int? idVille;
  final int? idPhoto;
  final int? idUtilisateur;
  final int? idUtilisateur1;
  final List<dynamic>? idTips;

  Plante({
    required this.idPlante,
    this.espece,
    this.description,
    this.categorie,
    this.etat,
    this.nom,
    this.lon,
    this.lat,
    this.idVille,
    this.idPhoto,
    this.idUtilisateur,
    this.idUtilisateur1,
    this.idTips,
  });

  factory Plante.fromJson(Map<String, dynamic> json) {
    return Plante(
      idPlante: json['idPlante'],
      espece: json['espece'],
      description: json['description'],
      categorie: json['categorie'],
      etat: json['etat'],
      nom: json['nom'],
      lon: json['lon'],
      lat: json['lat'],
      idVille: json['idVille'],
      idPhoto: json['idPhoto'],
      idUtilisateur: json['idUtilisateur'],
      idUtilisateur1: json['idUtilisateur1'],
      idTips: json['idTips'],
    );
  }
}
