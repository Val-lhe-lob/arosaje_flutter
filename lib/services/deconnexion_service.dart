import '../secure_local_storage_token.dart';

class DeconnexionService {
  final TokenStorage _tokenStorage = TokenStorage();

  Future<void> deconnexion() async {
    _tokenStorage.deleteToken();
  }
}
