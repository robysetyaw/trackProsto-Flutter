import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/meat.dart';

class MeatService {
  final String _baseUrl = 'http://10.0.2.2:8080';
  final _storage = FlutterSecureStorage();

  Future<List<Meat>> getMeats() async {
    final url = Uri.parse('$_baseUrl/meats');
    final token = await _storage.read(key: 'auth_token');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => Meat.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load meats');
    }
  }
}
