import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthenticationService {
  final String _baseUrl = 'http://10.0.2.2:8080';
  final _storage = FlutterSecureStorage();

  Future<bool> login(String username, String password) async {
    final url = Uri.parse('$_baseUrl/login');
    final request = http.Request('POST', url)
     ..headers['Content-Type'] = 'application/json'
     ..body = jsonEncode({
    'username': username,
    'password': password,
  });

    final response = await request.send().then(http.Response.fromStream);


    if (response.statusCode == 200) {
      final token = json.decode(response.body)['token '];
      await _storage.write(key: 'auth_token', value: token);
      return true;
    } else {
      return false;
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'auth_token');
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'auth_token');
    return token != null;
  }
}
