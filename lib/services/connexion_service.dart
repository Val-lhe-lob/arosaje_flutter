import 'package:dio/dio.dart';
import 'package:arosaje_flutter/config.dart';
import '../secure_local_storage_token.dart';

class ConnexionService {
  final TokenStorage _tokenStorage = TokenStorage();
  final Dio _dio = Dio();

  Future<bool> authenticate(String email, String mdp) async {
    try {
      final response = await _dio.post(
        Config.apiUrl + '/api/Token',
        data: {
          "email": email,
          "mdp": mdp,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        final token = response.data; // Extract the token from the response
        await _tokenStorage.storeToken(token, email);
        return true;
      } else {
        // Print detailed error information
        print('Failed to authenticate: ${response.statusCode}');
        print('Response body: ${response.data}');
        return false;
      }
    } catch (e) {
      // Print detailed error information
      print('Exception during authentication: $e');
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    try {
      final token = await _tokenStorage.getToken();
      return token != null;
    } catch (e) {
      // Print detailed error information
      print('Exception while checking login status: $e');
      return false;
    }
  }
}
