import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/customer.dart';

class CustomerService {
  final String _baseUrl = 'http://10.0.2.2:8080';
  final String _bearerToken = 'YOUR_TOKEN_HERE';  // Ganti dengan token Anda

  Future<List<Customer>> getCustomers() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/customers'),  // Pastikan URL ini benar
      headers: {'Authorization': 'Bearer $_bearerToken'},
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => Customer.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load customers');
    }
  }
}
