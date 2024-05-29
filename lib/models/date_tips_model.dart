class DateTips {
  final int idTips;
  final String contenu;

  DateTips({
    required this.idTips,
    required this.contenu,
  });

  factory DateTips.fromJson(Map<String, dynamic> json) {
    return DateTips(
      idTips: json['Id_Tips'],
      contenu: json['Contenu'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id_Tips': idTips,
      'Contenu': contenu,
    };
  }
}
