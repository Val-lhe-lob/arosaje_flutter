import 'plante_model.dart'; // Import the Plante model

class Ville {
  final int idVille;
  final String nom;
  final String desc;
  final List<Plante> plantes;

  Ville({
    required this.idVille,
    required this.nom,
    required this.desc,
    required this.plantes,
  });

  factory Ville.fromJson(Map<String, dynamic> json) {
    List<dynamic> plantesJson = json['plantes'] ?? [];
    List<Plante> plantesList = plantesJson.map((planteJson) => Plante.fromJson(planteJson)).toList();

    return Ville(
      idVille: json['idVille'],
      nom: json['nom'],
      desc: json['desc'],
      plantes: plantesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idVille': idVille,
      'nom': nom,
      'desc': desc,
      'plantes': plantes.map((plante) => plante.toJson()).toList(),
    };
  }
}
