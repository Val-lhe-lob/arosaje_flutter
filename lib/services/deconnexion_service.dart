import 'dart:ui';

import '../secure_local_storage_token.dart';

class DeconnexionService {
  final TokenStorage _tokenStorage = TokenStorage();

  Future<void> deconnexion(VoidCallback onLogout) async {
    await _tokenStorage.deleteToken();
    onLogout();
  }
}

