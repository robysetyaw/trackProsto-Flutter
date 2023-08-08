import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/stock_report.dart';
import '../services/stock_report_service.dart';

class StockReportView extends StatefulWidget {
  @override
  _StockReportViewState createState() => _StockReportViewState();
}

class _StockReportViewState extends State<StockReportView> {
  final _stockReportService = StockReportService();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  late Future<List<StockReport>> _stockReportFuture;

  @override
  void initState() {
    super.initState();
    _stockReportFuture = _stockReportService.getStockReport(
      DateFormat('yyyy-MM-dd').format(_startDate),
      DateFormat('yyyy-MM-dd').format(_endDate),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Report'),
      ),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            child: Text('Start Date: ${DateFormat('yyyy-MM-dd').format(_startDate)}'),
            onPressed: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: _startDate,
                firstDate: DateTime(DateTime.now().year - 5),
                lastDate: DateTime(DateTime.now().year + 5),
              );
              if (date != null) {
                setState(() {
                  _startDate = date;
                  _stockReportFuture = _stockReportService.getStockReport(DateFormat('yyyy-MM-dd').format(_startDate), DateFormat('yyyy-MM-dd').format(_endDate));
                });
              }
            },
          ),
          ElevatedButton(
            child: Text('End Date: ${DateFormat('yyyy-MM-dd').format(_endDate)}'),
            onPressed: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: _endDate,
                firstDate: DateTime(DateTime.now().year - 5),
                lastDate: DateTime(DateTime.now().year + 5),
              );
              if (date != null) {
                setState(() {
                  _endDate = date;
                  _stockReportFuture = _stockReportService.getStockReport(DateFormat('yyyy-MM-dd').format(_startDate), DateFormat('yyyy-MM-dd').format(_endDate));
                });
              }
            },
          ),
          Expanded(
            child: FutureBuilder<List<StockReport>>(
              future: _stockReportFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final item = snapshot.data![index];
                       return ListTile(
            title: Text(item.meatName),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Total Stock: ${item.totalStock.toString()}'),
                Text('Stock Movement: ${item.stockMovement.toString()}'),
                Text('Total Stock In: ${item.totalStockIn.toString()}'), // Menambahkan total stock in
                Text('Total Stock Out: ${item.totalStockOut.toString()}'), // Menambahkan total stock out
              ],
            ),
          );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
