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
  final Ville? ville; // Peut être null
  final String? lon; // Déclarez lon comme String nullable
  final String? lat; // Déclarez lat comme String nullable
  final Photo? photo; // Peut être null
  final Utilisateur? utilisateur; // Peut être null
  final Utilisateur? utilisateur1; // Peut être null

  Plante({
    required this.idPlante,
    required this.espece,
    required this.description,
    required this.categorie,
    required this.etat,
    required this.nom,
    this.ville,
    this.lon,
    this.lat,
    this.photo,
    this.utilisateur,
    this.utilisateur1,
  });

  factory Plante.fromJson(Map<String, dynamic> json) {
    return Plante(
      idPlante: json['idPlante'],
      espece: json['espece'],
      description: json['description'],
      categorie: json['categorie'],
      etat: json['etat'],
      nom: json['nom'],
      ville: json['idVilleNavigation'] != null ? Ville.fromJson(json['idVilleNavigation']) : null,
      lon: json['lon'] != null ? json['lon'] as String : null,
      lat: json['lat'] != null ? json['lat'] as String : null,
      photo: json['idPhotoNavigation'] != null ? Photo.fromJson(json['idPhotoNavigation']) : null,
      utilisateur: json['idUtilisateurNavigation'] != null ? Utilisateur.fromJson(json['idUtilisateurNavigation']) : null,
      utilisateur1: json['idUtilisateur1Navigation'] != null ? Utilisateur.fromJson(json['idUtilisateur1Navigation']) : null,
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
      'idVilleNavigation': ville?.toJson(),
      'lon': lon,
      'lat': lat,
      'idPhotoNavigation': photo?.toJson(),
      'idUtilisateurNavigation': utilisateur?.toJson(),
      'idUtilisateur1Navigation': utilisateur1?.toJson(),
    };
  }
}
