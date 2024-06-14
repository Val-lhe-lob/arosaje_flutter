import 'package:dio/dio.dart';
import '../config.dart';

class InscriptionService {
  Dio _dio = Dio();

  Future<bool> inscription(String nom, String prenom, int age, String email, String mdp, String repeatmdp) async {
    try {
      if (mdp == repeatmdp) {
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
          // Assuming the API response contains the new user's ID
          int userId = response.data['id'];

          final membreResponse = await _dio.post(
            Config.apiUrl + '/api/Membres',
            data: {
              "idUtilisateur": userId,
            },
            options: Options(
              headers: {'Content-Type': 'application/json'},
            ),
          );

          if (membreResponse.statusCode == 200 || membreResponse.statusCode == 201) {
            print("User and member registration successful");
            return true;
          } else {
            print("Failed to insert into Membre: " + membreResponse.statusCode.toString());
            return false;
          }
        } else {
          print("Code status: " + response.statusCode.toString());
          return false;
        }
      } else {
        print("Passwords do not match");
        return false;
      }
    } catch (e) {
      print('Exception during inscription: $e');
      return false;
    }
  }
}