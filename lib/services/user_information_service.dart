import 'package:dio/dio.dart';
import '../config.dart';
import '../secure_local_storage_token.dart';

class UserInformationService {
  final TokenStorage _tokenStorage = TokenStorage();
  Dio _dio = Dio();

  Future<Response> getAuthenticatedData(String? email) async {
    List? token = await _tokenStorage.getToken();
    if (token != null) {
      try {
        return await _dio.get(
          Config.apiUrl + '/api/Utilisateurs/name/$email',
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
          ),
        );
      } catch (e) {
        throw Exception('Error during authenticated data retrieval: $e');
      }
    } else {
      throw Exception('Token not found');
    }
  }
}
