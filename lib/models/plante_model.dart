import 'photo_model.dart';
import 'ville_model.dart';
import 'membre_model.dart';

class Plante {
  final int idPlante;
  final String espece;
  final String description;
  final String categorie;
  final String etat;
  final String nom;
  final Ville ville;
  final String lon;
  final int lat;
  final Photo? photo;
  final Membre utilisateur;
  final Membre utilisateur1;

  Plante({
    required this.idPlante,
    required this.espece,
    required this.description,
    required this.categorie,
    required this.etat,
    required this.nom,
    required this.ville,
    required this.lon,
    required this.lat,
    this.photo,
    required this.utilisateur,
    required this.utilisateur1,
  });

  factory Plante.fromJson(Map<String, dynamic> json) {
    return Plante(
      idPlante: json['Id_Plante'],
      espece: json['Espece'],
      description: json['Description'],
      categorie: json['Categorie'],
      etat: json['Etat'],
      nom: json['Nom'],
      ville: Ville.fromJson(json['Ville']),
      lon: json['Lon'],
      lat: json['Lat'],
      photo: json['Photo'] != null ? Photo.fromJson(json['Photo']) : null,
      utilisateur: Membre.fromJson(json['Utilisateur']),
      utilisateur1: Membre.fromJson(json['Utilisateur_1']),
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
      'Ville': ville.toJson(),
      'Lon': lon,
      'Lat': lat,
      'Photo': photo?.toJson(),
      'Utilisateur': utilisateur.toJson(),
      'Utilisateur_1': utilisateur1.toJson(),
    };
  }
}
