import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:arosaje_flutter/config.dart';
import '../secure_local_storage_token.dart';

class ConnexionService {
  final TokenStorage _tokenStorage = TokenStorage();
  Dio _dio = Dio();

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

      if (response.statusCode == 200) {
        final token = json.decode(response.data)['token'];
        await _tokenStorage.storeToken(token, email); // Store the token
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Exception during authentication: $e');
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _tokenStorage.getToken();
    return token != null;
  }
}
