
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meat_retailer/models/transaction.dart';

class TransactionService {
  final String _baseUrl = 'http://10.0.2.2:8080';  // Gantikan dengan baseURL Anda
  final _storage = FlutterSecureStorage();

  Future<List<Transaction>> getAllTransactions() async {
    final token = await _storage.read(key: 'auth_token');
    final response = await http.get(
      Uri.parse('$_baseUrl/transactions'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Transaction.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  Future<bool> addTransaction(Map<String, dynamic> transactionData) async {
  final token = await _storage.read(key: 'auth_token');
  final response = await http.post(
    Uri.parse('$_baseUrl/transactions'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: json.encode(transactionData),
  );

  return response.statusCode == 200;
}


}
