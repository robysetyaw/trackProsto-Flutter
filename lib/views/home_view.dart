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
      body: GridView.count(
        crossAxisCount: 2, // jumlah kolom
        children: <Widget>[
          Card(
            child: AspectRatio(
              aspectRatio: 3/2, 
              child: Center(child: Text('Customer')),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 3/2, 
              child: Center(child: Text('Company')),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 3/2, 
              child: Center(child: Text('Meat')),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 3/2, 
              child: Center(child: Text('Daily Expenditure')),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 3/2, 
              child: Center(child: Text('Transaction')),
            ),
          ),
          Card(
            child: AspectRatio(
              aspectRatio: 3/2, 
              child: Center(child: Text('Credit Payment')),
            ),
          ),
        ],
      ),
    );
  }
}
