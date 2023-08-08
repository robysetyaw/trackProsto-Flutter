import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';  // Pastikan Anda telah mengimport ini
import '../models/customer.dart';

class CustomerService {
  final String _baseUrl = 'http://10.0.2.2:8080';
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<List<Customer>> getCustomers() async {
    String? token = await _storage.read(key: 'auth_token');
    final response = await http.get(
      Uri.parse('$_baseUrl/customers'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',  // Menambahkan token ke header
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => Customer.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load customers');
    }
  }

    Future<void> addCustomer(String fullname, String address, String phoneNumber, String companyName) async {
    final url = Uri.parse('$_baseUrl/customers');
    final token = await _storage.read(key: 'auth_token');
    
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'fullname': fullname,
        'address': address,
        'phone_number': phoneNumber,
        'Company': {
          'company_name': companyName,
        },
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add customer');
    }
  }


}

