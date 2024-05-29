import 'plante_model.dart'; // Import the Plante model

class Ville {
  final int idVille;
  final String nom;
  final String desc;
  final List<Plante> plantes; // Make plantes field final

  Ville({
    required this.idVille,
    required this.nom,
    required this.desc,
    required this.plantes,
  });

  factory Ville.fromJson(Map<String, dynamic> json) {
    // Extract plantes data from JSON and map it to Plante objects
    List<dynamic> plantesJson = json['Plantes'];
    List<Plante> plantesList = plantesJson.map((planteJson) => Plante.fromJson(planteJson)).toList();

    return Ville(
      idVille: json['Id_Ville'],
      nom: json['Nom'],
      desc: json['Desc'],
      plantes: plantesList, // Assign the mapped list to plantes field
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id_Ville': idVille,
      'Nom': nom,
      'Desc': desc,
      'Plantes': plantes.map((plante) => plante.toJson()).toList(),
    };
  }
}
