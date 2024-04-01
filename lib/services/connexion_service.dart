import 'package:http/http.dart' as http;
import 'dart:convert';
import '../secure_local_storage_token.dart';

class ConnexionService {
  final _baseUrl = 'https://yourapi.com';
  final TokenStorage _tokenStorage = TokenStorage();

  Future<bool> authenticate(String email, String mdp) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/api/Token'),
      body: jsonEncode({
        "email": email,
        "mdp": mdp,
      }),
      headers: {'Content-Type': 'application/json'},
    );
    if ( response.statusCode != 200 ){
      return false;
    }

    else if (response.statusCode == 200) {
      final token = json.decode(response.body)['token'];
      await _tokenStorage.storeToken(token); // Store the token
      return true;
    } else {
      throw Exception('Failed to authenticate');

    }
    
  }

  Future<bool> isLoggedIn() async {
    final token = await _tokenStorage.getToken();
    return token != null;
  }
}
