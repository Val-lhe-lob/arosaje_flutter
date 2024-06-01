class Plante {
  final int idPlante;
  final String espece;
  final String description;
  final String categorie;
  final String etat;
  final String nom;
  final int idVille;
  final String lon;
  final String lat;
  final int? idPhoto;
  final int idUtilisateur;
  final int idUtilisateur1;

  Plante({
    required this.idPlante,
    required this.espece,
    required this.description,
    required this.categorie,
    required this.etat,
    required this.nom,
    required this.idVille,
    required this.lon,
    required this.lat,
    this.idPhoto,
    required this.idUtilisateur,
    required this.idUtilisateur1,
  });

  factory Plante.fromJson(Map<String, dynamic> json) {
    return Plante(
      idPlante: json['idPlante'],
      espece: json['espece'],
      description: json['description'],
      categorie: json['categorie'],
      etat: json['etat'],
      nom: json['nom'],
      idVille: json['idVille'],
      lon: json['lon'],
      lat: json['lat'],
      idPhoto: json['idPhoto'],
      idUtilisateur: json['idUtilisateur'],
      idUtilisateur1: json['idUtilisateur1'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idPlante': idPlante,
      'espece': espece,
      'description': description,
      'categorie': categorie,
      'etat': etat,
      'nom': nom,
      'idVille': idVille,
      'lon': lon,
      'lat': lat,
      'idPhoto': idPhoto,
      'idUtilisateur': idUtilisateur,
      'idUtilisateur1': idUtilisateur1,
    };
  }
}
