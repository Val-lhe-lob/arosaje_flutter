class Plante {
  final int idPlante;
  final String espece;
  final String description;
  final String categorie;
  final String etat;
  final String nom;
  final int idVille;
  final String lon;
  final int lat;
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
      idPlante: json['Id_Plante'],
      espece: json['Espece'],
      description: json['Description'],
      categorie: json['Categorie'],
      etat: json['Etat'],
      nom: json['Nom'],
      idVille: json['Id_Ville'],
      lon: json['Lon'],
      lat: json['Lat'],
      idPhoto: json['Id_Photo'],
      idUtilisateur: json['Id_Utilisateur'],
      idUtilisateur1: json['Id_Utilisateur_1'],
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
      'Id_Ville': idVille,
      'Lon': lon,
      'Lat': lat,
      'Id_Photo': idPhoto,
      'Id_Utilisateur': idUtilisateur,
      'Id_Utilisateur_1': idUtilisateur1,
    };
  }
}
