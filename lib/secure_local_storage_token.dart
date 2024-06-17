import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final _storage = FlutterSecureStorage();

  Future<void> storeToken(String token,String email) async {
    await _storage.write(key: 'jwt_token', value: token);
    await _storage.write(key: 'user_email', value: email);
  }

  Future<void> storeId(int id) async {
    await _storage.write(key: 'user_id', value: id.toString());
  }

  Future<List?> getToken() async {
    return [await _storage.read(key: 'jwt_token'),await _storage.read(key:'user_email'),await _storage.read(key:'user_id')];
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: 'jwt_token');
    await _storage.delete(key: 'user_email');
    await _storage.delete(key:'user_id');
  }
}