import 'package:flutter/material.dart';
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
    _stockReportFuture = _stockReportService.getStockReport(_startDate.toString(), _endDate.toString());
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
            child: Text('Start Date: $_startDate'),
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
                  _stockReportFuture = _stockReportService.getStockReport(_startDate.toString(), _endDate.toString());
                });
              }
            },
          ),
          ElevatedButton(
            child: Text('End Date: $_endDate'),
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
                  _stockReportFuture = _stockReportService.getStockReport(_startDate.toString(), _endDate.toString());
                });
              }
            },
          ),
          FutureBuilder<List<StockReport>>(
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
                      subtitle: Text('Stock Movement: ${item.stockMovement.toString()}'),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
