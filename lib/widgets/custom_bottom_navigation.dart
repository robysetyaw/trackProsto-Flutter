import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  CustomBottomNavigationBar({required this.currentIndex, required this.onTabSelected});

  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: widget.onTabSelected,
      currentIndex: widget.currentIndex,
      selectedItemColor: Colors.blue, // Warna untuk item yang sedang dipilih
      unselectedItemColor: Colors.grey, // Warna untuk item yang tidak dipilih
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.show_chart), // Gunakan ikon yang sesuai dengan kebutuhan Anda
          label: 'Stock Report',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.swap_horiz), // Gunakan ikon yang sesuai dengan kebutuhan Anda
          label: 'Transactions',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Users',
        ),
      ],
    );
  }
}
