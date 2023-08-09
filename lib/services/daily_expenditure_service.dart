import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:meat_retailer/models/daily_expenditure.dart'; // Import model DailyExpenditure

class DailyExpenditureService {
  final String _baseUrl = 'http://10.0.2.2:8080';
  final _storage = FlutterSecureStorage();

  Future<List<DailyExpenditure>> getAllDailyExpenditures() async {
    final token = await _storage.read(key: 'auth_token');
    final response = await http.get(
      Uri.parse('$_baseUrl/daily-expenditures'), // Gantilah 'path_to_endpoint' dengan endpoint yang sesuai
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => DailyExpenditure.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load daily expenditures');
    }
  }
}
