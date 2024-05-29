class Photo {
  final int idPhoto;
  final String image;

  Photo({
    required this.idPhoto,
    required this.image,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      idPhoto: json['Id_Photo'],
      image: json['Image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id_Photo': idPhoto,
      'Image': image,
    };
  }
}
