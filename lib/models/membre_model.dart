import 'package:arosaje_flutter/models/membre_mode.dart';
import 'package:arosaje_flutter/models/photo_model.dart';

class Prendre {
  final int idUtilisateur;
  final int idPhoto;
  final Membre membre;
  final Photo photo;

  Prendre({
    required this.idUtilisateur,
    required this.idPhoto,
    required this.membre,
    required this.photo,
  });

  factory Prendre.fromJson(Map<String, dynamic> json) {
    return Prendre(
      idUtilisateur: json['Id_Utilisateur'],
      idPhoto: json['Id_Photo'],
      membre: Membre.fromJson(json['Membre']),
      photo: Photo.fromJson(json['Photo']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id_Utilisateur': idUtilisateur,
      'Id_Photo': idPhoto,
      'Membre': membre.toJson(),
      'Photo': photo.toJson(),
    };
  }
}
