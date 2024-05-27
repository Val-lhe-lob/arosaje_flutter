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
          print("ça a réussi normalement");
          return true;
        } else {
          print("Code statut : " + response.statusCode.toString());
          return false;
        }
      } else {
        print("L'inscription n'a pas abouti");
        print("$mdp = $repeatmdp");
        return false;
      }
    } catch (e) {
      print('Exception during inscription: $e');
      return false;
    }
  }
}
