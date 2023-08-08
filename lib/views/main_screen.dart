import 'package:flutter/material.dart';
import 'package:meat_retailer/views/stock_report_view.dart';

import '../widgets/custom_bottom_navigation.dart';
import 'home_view.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentTab = 0;

  // Fungsi untuk mengembalikan halaman berdasarkan index tab
  Widget _getPageAt(int index) {
    switch (index) {
      case 0:
        return HomeView();
      case 1:
        return StockReportView();
      case 2:
        // return TransactionView();
      case 3:
        // return UsersView();
      default:
        return HomeView();
    }
  }

  void _onTabSelected(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPageAt(_currentTab),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentTab,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}
