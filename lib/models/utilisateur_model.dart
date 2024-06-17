class Utilisateur {
  final int idUtilisateur;
  final String nom;
  final String mdp;
  final String email;
  final String prenom;
  final int age;
  final dynamic botaniste;
  final dynamic membre;
  final dynamic proprio;
  final List<dynamic> idVilles;

  Utilisateur({
    required this.idUtilisateur,
    required this.nom,
    required this.mdp,
    required this.email,
    required this.prenom,
    required this.age,
    this.botaniste,
    this.membre,
    this.proprio,
    required this.idVilles,
  });

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      idUtilisateur: json['idUtilisateur'],
      nom: json['nom'],
      mdp: json['mdp'],
      email: json['email'],
      prenom: json['prenom'],
      age: json['age'], // Ensure this is an int
      botaniste: json['botaniste'],
      membre: json['membre'],
      proprio: json['proprio'],
      idVilles: List<dynamic>.from(json['idVilles']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idUtilisateur': idUtilisateur,
      'nom': nom,
      'mdp': mdp,
      'email': email,
      'prenom': prenom,
      'age': age,
      'botaniste': botaniste,
      'membre': membre,
      'proprio': proprio,
      'idVilles': idVilles,
    };
  }
}
