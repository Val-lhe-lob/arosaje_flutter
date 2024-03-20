class Utilisateur {
  final int idUtilisateur;
  final String nom;
  final String mdp;
  final String email;
  final String prenom;
  final int age;
  final Botaniste botaniste;
  final Membre membre;
  final Proprio proprio;
  final List<int> idVilles;

  Utilisateur({
    required this.idUtilisateur,
    required this.nom,
    required this.mdp,
    required this.email,
    required this.prenom,
    required this.age,
    required this.botaniste,
    required this.membre,
    required this.proprio,
    required this.idVilles,
  });

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      idUtilisateur: json['idUtilisateur'],
      nom: json['nom'],
      mdp: json['mdp'],
      email: json['email'],
      prenom: json['prenom'],
      age: json['age'],
      botaniste: Botaniste.fromJson(json['botaniste']),
      membre: Membre.fromJson(json['membre']),
      proprio: Proprio.fromJson(json['proprio']),
      idVilles: List<int>.from(json['idVilles']),
    );
  }
}

class Botaniste {
  final int idUtilisateur;
  final List<EnvoyerRecevoir> envoyerRecevoirs;
  final Utilisateur idUtilisateurNavigation;
  final List<Tips> idTips;

  Botaniste({
    required this.idUtilisateur,
    required this.envoyerRecevoirs,
    required this.idUtilisateurNavigation,
    required this.idTips,
  });

  factory Botaniste.fromJson(Map<String, dynamic> json) {
    return Botaniste(
      idUtilisateur: json['idUtilisateur'],
      envoyerRecevoirs: List<EnvoyerRecevoir>.from(json['envoyerRecevoirs'].map((x) => EnvoyerRecevoir.fromJson(x))),
      idUtilisateurNavigation: Utilisateur.fromJson(json['idUtilisateurNavigation']),
      idTips: List<Tips>.from(json['idTips'].map((x) => Tips.fromJson(x))),
    );
  }
}

class Membre {
  final int idUtilisateur;
  final List<EnvoyerRecevoir> envoyerRecevoirs;
  final Utilisateur idUtilisateurNavigation;
  final List<Plante> planteIdUtilisateur1Navigations;
  final List<Plante> planteIdUtilisateurNavigations;
  final List<Photo> idPhotos;

  Membre({
    required this.idUtilisateur,
    required this.envoyerRecevoirs,
    required this.idUtilisateurNavigation,
    required this.planteIdUtilisateur1Navigations,
    required this.planteIdUtilisateurNavigations,
    required this.idPhotos,
  });

  factory Membre.fromJson(Map<String, dynamic> json) {
    return Membre(
      idUtilisateur: json['idUtilisateur'],
      envoyerRecevoirs: List<EnvoyerRecevoir>.from(json['envoyerRecevoirs'].map((x) => EnvoyerRecevoir.fromJson(x))),
      idUtilisateurNavigation: Utilisateur.fromJson(json['idUtilisateurNavigation']),
      planteIdUtilisateur1Navigations: List<Plante>.from(json['planteIdUtilisateur1Navigations'].map((x) => Plante.fromJson(x))),
      planteIdUtilisateurNavigations: List<Plante>.from(json['planteIdUtilisateurNavigations'].map((x) => Plante.fromJson(x))),
      idPhotos: List<Photo>.from(json['idPhotos'].map((x) => Photo.fromJson(x))),
    );
  }
}

class Proprio {
  final int idUtilisateur;
  final List<EnvoyerRecevoir> envoyerRecevoirs;
  final Utilisateur idUtilisateurNavigation;

  Proprio({
    required this.idUtilisateur,
    required this.envoyerRecevoirs,
    required this.idUtilisateurNavigation,
  });

  factory Proprio.fromJson(Map<String, dynamic> json) {
    return Proprio(
      idUtilisateur: json['idUtilisateur'],
      envoyerRecevoirs: List<EnvoyerRecevoir>.from(json['envoyerRecevoirs'].map((x) => EnvoyerRecevoir.fromJson(x))),
      idUtilisateurNavigation: Utilisateur.fromJson(json['idUtilisateurNavigation']),
    );
  }
}

class EnvoyerRecevoir {
  final int idUtilisateur;
  final int idUtilisateur1;
  final int idUtilisateur2;
  final int idMessage;
  final Message idMessageNavigation;
  final String idUtilisateur1Navigation;
  final String idUtilisateur2Navigation;
  final String idUtilisateurNavigation;

  EnvoyerRecevoir({
    required this.idUtilisateur,
    required this.idUtilisateur1,
    required this.idUtilisateur2,
    required this.idMessage,
    required this.idMessageNavigation,
    required this.idUtilisateur1Navigation,
    required this.idUtilisateur2Navigation,
    required this.idUtilisateurNavigation,
  });

  factory EnvoyerRecevoir.fromJson(Map<String, dynamic> json) {
    return EnvoyerRecevoir(
      idUtilisateur: json['idUtilisateur'],
      idUtilisateur1: json['idUtilisateur1'],
      idUtilisateur2: json['idUtilisateur2'],
      idMessage: json['idMessage'],
      idMessageNavigation: Message.fromJson(json['idMessageNavigation']),
      idUtilisateur1Navigation: json['idUtilisateur1Navigation'],
      idUtilisateur2Navigation: json['idUtilisateur2Navigation'],
      idUtilisateurNavigation: json['idUtilisateurNavigation'],
    );
  }
}

class Tips {
  final int idTips;
  final String contenu;
  final List<String> idPlantes;
  final List<String> idUtilisateurs;

  Tips({
    required this.idTips,
    required this.contenu,
    required this.idPlantes,
    required this.idUtilisateurs,
  });

  factory Tips.fromJson(Map<String, dynamic> json) {
    return Tips(
      idTips: json['idTips'],
      contenu: json['contenu'],
      idPlantes: List<String>.from(json['idPlantes'].map((x) => x)),
      idUtilisateurs: List<String>.from(json['idUtilisateurs'].map((x) => x)),
    );
  }
}

class Message {
  final int idMessage;
  final String contenu;
  final DateTime dateMessage;
  final List<String> envoyerRecevoirs;

  Message({
    required this.idMessage,
    required this.contenu,
    required this.dateMessage,
    required this.envoyerRecevoirs,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      idMessage: json['idMessage'],
      contenu: json['contenu'],
      dateMessage: DateTime.parse(json['dateMessage']),
      envoyerRecevoirs: List<String>.from(json['envoyerRecevoirs'].map((x) => x)),
    );
  }
}

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

class Photo {
  final int idPhoto;
  final String image;
  final List<String> plantes;
  final List<String> idUtilisateurs;

  Photo({
    required this.idPhoto,
    required this.image,
    required this.plantes,
    required this.idUtilisateurs,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      idPhoto: json['idPhoto'],
      image: json['image'],
      plantes: List<String>.from(json['plantes'].map((x) => x)),
      idUtilisateurs: List<String>.from(json['idUtilisateurs'].map((x) => x)),
    );
  }
}