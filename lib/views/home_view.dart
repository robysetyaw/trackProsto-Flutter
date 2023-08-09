import 'package:flutter/material.dart';
import 'package:meat_retailer/views/company_view.dart';
import 'package:meat_retailer/views/daily_expenditure_view.dart';
import 'package:meat_retailer/views/meat_view.dart';
import 'package:meat_retailer/views/transaction_view.dart';
import 'customer_view.dart'; // Pastikan Anda mengimpor CustomerView

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          padding: const EdgeInsets.all(10),
          childAspectRatio: 3 / 2,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomerView()),
                );
              },
              child: Card(
                child: Container(
                  constraints: BoxConstraints.tightFor(height: 150),
                  child: Center(child: Text('Customer')),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CompanyView()),
                );
              },
              child: Card(
                child: Container(
                  constraints: BoxConstraints.tightFor(height: 150),
                  child: Center(child: Text('Company')),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MeatView()),
                );
              },
              child: Card(
                child: Container(
                  constraints: BoxConstraints.tightFor(height: 150),
                  child: Center(child: Text('Meat')),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DailyExpenditureView()),
                );
              },
              child: Card(
                child: Container(
                  constraints: BoxConstraints.tightFor(height: 150),
                  child: Center(child: Text('Daily Expenditure')),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TransactionView()),
                );
              },
              child: Card(
                child: Container(
                  constraints: BoxConstraints.tightFor(height: 150),
                  child: Center(child: Text('Transaction')),
                ),
              ),
            ),
            Card(
              child: Container(
                constraints: BoxConstraints.tightFor(height: 150),
                child: Center(child: Text('Credit Payment')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
