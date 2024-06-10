import 'dart:convert';
import 'package:arosaje_flutter/models/photo_model.dart';
import 'package:http/http.dart' as http;

class PhotoService {
  final String baseUrl;

  PhotoService({required this.baseUrl});

  Future<List<Photo>> fetchPhotos() async {
    final response = await http.get(Uri.parse('$baseUrl/api/photos'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Photo> photos = body.map((dynamic item) => Photo.fromJson(item)).toList();
      return photos;
    } else {
      throw Exception('Failed to load photos');
    }
  }

  Future<Photo> fetchLatestPhoto() async {
    List<Photo> photos = await fetchPhotos();
    
    // Assuming that the photos list is ordered by date, latest first.
    if (photos.isNotEmpty) {
      return photos.last; // Return the latest photo
    } else {
      throw Exception('No photos found');
    }
  }
}
