import 'plante_model.dart'; // Import the Plante model

class Ville {
  final int idVille;
  final String nom;
  final String desc;
  List<Plante> plantes; // Modifier pour ne pas le rendre final

  Ville({
    required this.idVille,
    required this.nom,
    required this.desc,
    required this.plantes,
  });

  factory Ville.fromJson(Map<String, dynamic> json) {
    List<dynamic> plantesJson = json['plantes']; // Assurez-vous que la clé est en minuscules
    List<Plante> plantesList = plantesJson.map((planteJson) => Plante.fromJson(planteJson)).toList();

    return Ville(
      idVille: json['idVille'], // Assurez-vous que la clé est en minuscules
      nom: json['nom'], // Assurez-vous que la clé est en minuscules
      desc: json['desc'], // Assurez-vous que la clé est en minuscules
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

