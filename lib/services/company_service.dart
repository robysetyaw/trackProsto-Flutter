import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meat_retailer/models/company.dart';

class CompanyService {
  final String _baseUrl = 'http://10.0.2.2:8080';
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<List<Company>> getAllCompanies() async {
    final url = Uri.parse('$_baseUrl/companies'); // Pastikan endpoint-nya benar.
    final token = await _storage.read(key: 'auth_token');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> companiesJson = json.decode(response.body);
      return companiesJson.map((json) => Company.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load companies');
    }
  }

  Future<bool> addCompany(Company company) async {
    final token = await _storage.read(key: 'auth_token');
    final response = await http.post(
      Uri.parse('$_baseUrl/companies'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'company_name': company.companyName,
        'address': company.address,
        'email': company.email,
        'phone_number': company.phoneNumber,
      }),
    );
    return response.statusCode == 200;
  }
}
