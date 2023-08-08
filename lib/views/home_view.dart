import 'package:flutter/material.dart';
import 'package:meat_retailer/widgets/custom_bottom_navigation.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  // Daftar Widget untuk setiap tab. Ganti ini dengan halaman yang sebenarnya.
  final List<Widget> _children = [
    Text('Home Tab'),
    Text('Messages Tab'),
    Text('Profile Tab'),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // TODO: Implement logout functionality
            },
          ),
        ],
      ),
      body: _children[_currentIndex], // Menampilkan halaman yang sesuai dengan tab aktif
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTabSelected: onTabTapped,
      ),
    );
  }
}
