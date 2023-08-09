import 'package:flutter/material.dart';
import 'package:meat_retailer/models/daily_expenditure.dart';
import 'package:meat_retailer/services/daily_expenditure_service.dart';

class DailyExpenditureView extends StatefulWidget {
  @override
  _DailyExpenditureViewState createState() => _DailyExpenditureViewState();
}

class _DailyExpenditureViewState extends State<DailyExpenditureView> {
  final _dailyExpenditureService = DailyExpenditureService();
  late Future<List<DailyExpenditure>> _dailyExpenditureFuture;

  @override
  void initState() {
    super.initState();
    _dailyExpenditureFuture = _dailyExpenditureService.getAllDailyExpenditures();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Expenditures'),
      ),
      body: FutureBuilder<List<DailyExpenditure>>(
        future: _dailyExpenditureFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                final dailyExpenditure = snapshot.data![index];
                return ListTile(
                  title: Text(dailyExpenditure.deNote),
                  subtitle: Text(dailyExpenditure.description),
                  trailing: Text(dailyExpenditure.amount.toString()),
                );
              },
            );
          }
        },
      ),
    );
  }
}
