import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DataStorage {
  final _storage = FlutterSecureStorage();

  void storeAccessCode(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  Future<String> getAccessCode() async {
    return await _storage.read(key: 'token');
  }
}
