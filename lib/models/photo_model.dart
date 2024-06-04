class Photo {
  final int idPhoto;
  final String image;
  final String extension;

  Photo({
    required this.idPhoto,
    required this.image,
    required this.extension
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      idPhoto: json['Id_Photo'],
      image: json['Image'],
      extension: json['extension']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id_Photo': idPhoto,
      'Image': image,
      'extension':extension,
    };
  }
}
