import 'package:arosaje_flutter/config.dart';
import 'package:dio/dio.dart';
import 'package:arosaje_flutter/models/utilisateur_model.dart';

class UserInformationService {
  final Dio _dio = Dio();

  Future<Utilisateur?> getAuthenticatedData(String token, String email) async {
    try {
      final response = await _dio.get(
        '${Config.apiUrl}/api/Utilisateurs/name/$email',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      // Print the entire response for debugging
      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        // Print the parsed JSON data
        print('Parsed user data: ${response.data}');
        return Utilisateur.fromJson(response.data);
      } else {
        print('Failed to retrieve user data: ${response.statusCode}');
        print('Response body: ${response.data}');
        return null;
      }
    } on DioError catch (e) {
      print('DioError: ${e.response?.data}');
      return null;
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }
}
