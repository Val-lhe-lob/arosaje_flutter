import 'package:arosaje_flutter/models/photo_model.dart';
import 'package:arosaje_flutter/models/utilisateur_model.dart';
import 'package:arosaje_flutter/models/ville_model.dart';

class Plante {
  final int idPlante;
  final String espece;
  final String description;
  final String categorie;
  final String etat;
  final String nom;
  final Ville ville;
  final String lon;
  final int? lat; // Déclarez lat comme un int nullable
  final Photo photo;
  final Utilisateur? utilisateur;
  final Utilisateur? utilisateur1;

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
    required this.photo,
    this.utilisateur,
    this.utilisateur1,
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
      lat: json['Lat'] != null ? json['Lat'] as int : null,
      photo: json['Photo'],
      utilisateur: Utilisateur.fromJson(json['Utilisateur']),
      utilisateur1: Utilisateur.fromJson(json['Utilisateur_1']),
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
      'Photo': photo.toJson(),
      'Utilisateur': utilisateur?.toJson(),
      'Utilisateur_1': utilisateur1?.toJson(),
    };
  }
}
