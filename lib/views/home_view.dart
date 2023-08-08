import 'package:flutter/material.dart';

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
      body: Center(  // Tambahkan widget Center di sini
        child: GridView.count(
          crossAxisCount: 2, // jumlah kolom
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          padding: const EdgeInsets.all(10),
          childAspectRatio: 3 / 2,
          children: <Widget>[
            Card(
              child: Container(
                constraints: BoxConstraints.tightFor(height: 150),
                child: Center(child: Text('Customer')),  // Dan di sini
              ),
            ),
            Card(
              child: Container(
                constraints: BoxConstraints.tightFor(height: 150),
                child: Center(child: Text('Company')),
              ),
            ),
            Card(
              child: Container(
                constraints: BoxConstraints.tightFor(height: 150),
                child: Center(child: Text('Meat')),
              ),
            ),
            Card(
              child: Container(
                constraints: BoxConstraints.tightFor(height: 150),
                child: Center(child: Text('Daily Expenditure')),
              ),
            ),
            Card(
              child: Container(
                constraints: BoxConstraints.tightFor(height: 150),
                child: Center(child: Text('Transaction')),
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
