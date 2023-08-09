import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    _dailyExpenditureFuture =
        _dailyExpenditureService.getAllDailyExpenditures();
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
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(dailyExpenditure.description),
                      SizedBox(height: 4.0),
                      Text(DateFormat('yyyy-MM-dd')
                          .format(dailyExpenditure.date)),
                    ],
                  ),
                  trailing: Text(dailyExpenditure.amount.toString()),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDailyExpenditureDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddDailyExpenditureDialog() {
    final TextEditingController amountController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Daily Expenditure"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: amountController,
                decoration: InputDecoration(labelText: "Amount"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description"),
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text("Add"),
              onPressed: () async {
                if (amountController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty) {
                  final bool success = await _addDailyExpenditure(
                    double.parse(amountController.text),
                    descriptionController.text,
                  );

                  if (success) {
                    Navigator.of(context).pop();
                    setState(() {
                      _dailyExpenditureFuture =
                          _dailyExpenditureService.getAllDailyExpenditures();
                    });
                  } else {
                    // Handle error here
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> _addDailyExpenditure(double amount, String description) async {
    final dailyExpenditure = {
      "amount": amount,
      "description": description,
    };
    return await _dailyExpenditureService.addDailyExpenditure(dailyExpenditure);
  }
}
