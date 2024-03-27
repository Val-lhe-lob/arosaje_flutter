import 'package:http/http.dart' as http;
import 'dart:convert';
import '../secure_local_storage_token.dart';

class ApiService {
  final _baseUrl = 'https://yourapi.com';
  final TokenStorage _tokenStorage = TokenStorage();

  Future<http.Response> getAuthenticatedData( String email, String mdp) async {
    String? token = await _tokenStorage.getToken();
    return http.post(
      Uri.parse('$_baseUrl/api/Token'),
        body: jsonEncode({
      "email": email,
      "mdp": mdp,
      }),
        headers: {'Content-Type': 'application/json'},
      
    );
  }
}