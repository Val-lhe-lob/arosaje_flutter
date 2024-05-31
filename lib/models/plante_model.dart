class Plante {
  final int idPlante;
  final String espece;
  final String? description;
  final String categorie;
  final String etat;
  final String nom;
  final String lon;
  final String lat;
  final int idVille;
  final int idPhoto;
  final int idUtilisateur;
  final int idUtilisateur1;

  Plante({
    required this.idPlante,
    required this.espece,
    this.description,
    required this.categorie,
    required this.etat,
    required this.nom,
    required this.lon,
    required this.lat,
    required this.idVille,
    required this.idPhoto,
    required this.idUtilisateur,
    required this.idUtilisateur1,
  });

  factory Plante.fromJson(Map<String, dynamic> json) {
    return Plante(
      idPlante: json['Id_Plante'] ?? 0,
      espece: json['Espece'] ?? '',
      description: json['Description'],
      categorie: json['Categorie'] ?? '',
      etat: json['Etat'] ?? '',
      nom: json['Nom'] ?? '',
      lon: json['Lon'] ?? '',
      lat: json['Lat'] ?? '',
      idVille: json['Id_Ville'] ?? 0,
      idPhoto: json['Id_Photo'] ?? 0,
      idUtilisateur: json['Id_Utilisateur'] ?? 0,
      idUtilisateur1: json['Id_Utilisateur1'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id_Plante': idPlante,
      'Espece': espece,
      'Description': description,
      'Categorie': categorie,
      'Etat': etat,
      'Nom': nom,
      'Lon': lon,
      'Lat': lat,
      'Id_Ville': idVille,
      'Id_Photo': idPhoto,
      'Id_Utilisateur': idUtilisateur,
      'Id_Utilisateur1': idUtilisateur1,
    };
  }
}
