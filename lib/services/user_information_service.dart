import 'package:dio/dio.dart';
import '../config.dart';
import '../secure_local_storage_token.dart';
import 'package:arosaje_flutter/models/utilisateur_model.dart';

class UserInformationService {
  final TokenStorage _tokenStorage = TokenStorage();
  Dio _dio = Dio();

  Future<Utilisateur> getAuthenticatedData(String? email) async {
    List? token = await _tokenStorage.getToken();
    if (token != null) {
      try {
        Response response = await _dio.get(
          Config.apiUrl + '/api/Utilisateurs/name/$email',
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ),
        );
        // Check if the response status code is 200
        if (response.statusCode == 200) {
          // Parse the response data into a Utilisateur object
          return Utilisateur.fromJson(response.data);
        } else {
          // Handle non-200 status code
          throw Exception('Failed to get user data: ${response.statusCode}');
        }
      } catch (e) {
        throw Exception('Error during authenticated data retrieval: $e');
      }
    } else {
      throw Exception('Token not found');
    }
  }
}
