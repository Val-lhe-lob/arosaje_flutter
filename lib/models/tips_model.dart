class Tips {
  final int idTips;
  final String contenu;

  Tips({
    required this.idTips,
    required this.contenu,
  });

  factory Tips.fromJson(Map<String, dynamic> json) {
    return Tips(
      idTips: json['Id_Tips'],
      contenu: json['contenu'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id_Tips': idTips,
      'contenu': contenu,
    };
  }
}
