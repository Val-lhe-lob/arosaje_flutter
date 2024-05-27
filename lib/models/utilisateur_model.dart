

class Utilisateur {
  final int idUtilisateur;
  final String nom;
  final String mdp;
  final String email;
  final String prenom;
  final String age;

  Utilisateur({
    required this.idUtilisateur,
    required this.nom,
    required this.mdp,
    required this.email,
    required this.prenom,
    required this.age,
  });

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      idUtilisateur: json['Id_Utilisateur'],
      nom: json['Nom'],
      mdp: json['Mdp'],
      email: json['Email'],
      prenom: json['Prenom'],
      age: json['Age'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id_Utilisateur': idUtilisateur,
      'Nom': nom,
      'Mdp': mdp,
      'Email': email,
      'Prenom': prenom,
      'Age': age,
    };
  }
}
