import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/stock_report.dart';

class StockReportService {
  final String _baseUrl = 'http://10.0.2.2:8080';

  Future<List<StockReport>> getStockReport(String startDate, String endDate) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/report/stock-movement?start_date=$startDate&end_date=$endDate'),
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => StockReport.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load stock report');
    }
  }
}
