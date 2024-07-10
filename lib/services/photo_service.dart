import 'dart:convert';
import 'package:arosaje_flutter/config.dart';
import 'package:arosaje_flutter/models/photo_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class PhotoService {
  
     static Dio _dio = Dio()..interceptors.add(LogInterceptor(responseBody: true));

  
  Future<List<Photo>> fetchPhotos() async {
    final response = await http.get(Uri.parse(Config.apiUrl+'/api/photos'));

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

  Future<Photo?> getPhoto(int id) async {
    try {
      final response = await _dio.get(Config.apiUrl + '/api/photos/$id',);

       final data = response.data;
        if (data is Map<String, dynamic>) {
          return Photo.fromJson(data);
        } else {
          print('Unexpected response format: $data');
          return null;
        }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
