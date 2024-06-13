class Photo {
  final int idPhoto;
  final String? image;
  final String? extension;

  Photo({
    required this.idPhoto,
    this.image,
    this.extension,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      idPhoto: json['idPhoto'],
      image: json['image'],
      extension: json['extension'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idPhoto': idPhoto,
      'image': image,
      'extension': extension,
    };
  }
}
