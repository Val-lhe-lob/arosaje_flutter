import 'package:dio/dio.dart';
import '../config.dart';

class InscriptionService {
  Dio _dio = Dio();

  Future<bool> checkEmailExists(String email) async {
    try {
      final response = await _dio.get(
        Config.apiUrl + '/api/Utilisateurs/name/$email',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<bool> checkUsernameExists(String username) async {
    try {
      final response = await _dio.get(
        Config.apiUrl + '/api/Utilisateurs/username/$username',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<String> inscription(String nom, String prenom, int age, String email, String mdp, String repeatmdp) async {
    if (mdp != repeatmdp) {
      return 'password_mismatch';
    }

    bool emailExists = await checkEmailExists(email);
    if (emailExists) {
      return 'email_exists';
    }

    bool usernameExists = await checkUsernameExists(nom);
    if (usernameExists) {
      return 'username_exists';
    }

    try {
      final response = await _dio.post(
        Config.apiUrl + '/api/Utilisateurs',
        data: {
          "nom": nom,
          "mdp": mdp,
          "email": email,
          "prenom": prenom,
          "age": age,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        int userId = response.data['idUtilisateur'];
        final membreResponse = await _dio.post(
          Config.apiUrl + '/api/Membres/CreateWithUserId',
          data: {
            "idUtilisateur": userId,
          },
          options: Options(
            headers: {'Content-Type': 'application/json'},
          ),
        );

        if (membreResponse.statusCode == 200 || membreResponse.statusCode == 201) {
          return 'success';
        } else {
          return 'member_creation_failed';
        }
      } else {
        return 'registration_failed';
      }
    } catch (e) {
      return 'error';
    }
  }
}
