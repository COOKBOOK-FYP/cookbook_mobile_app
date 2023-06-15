// ignore_for_file: file_names

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _storage = FlutterSecureStorage();

  static const _keyToken = 'token';
  static const _keyUserId = 'userId';
  static const _keyNewUser = 'newUser';

  static Future setToken(String token) async {
    await _storage.write(key: _keyToken, value: token);
  }

  static Future<String?> fetchToken() async {
    return await _storage.read(key: _keyToken);
  }

  static Future setUserId(String userId) async {
    await _storage.write(key: _keyUserId, value: userId);
  }

  static Future<String?> fetchUserId() async {
    return await _storage.read(key: _keyUserId);
  }

  static Future setNewUser(String newUser) async {
    await _storage.write(key: _keyNewUser, value: newUser);
  }

  static Future<String?> fetchNewUser() async {
    return await _storage.read(key: _keyNewUser);
  }

  static Future deleteSecureStorage() async {
    await _storage.delete(key: _keyToken);
    await _storage.delete(key: _keyUserId);
  }
}
