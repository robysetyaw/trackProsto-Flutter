import 'package:flutter/material.dart';
import 'package:meat_retailer/views/login_view.dart';
import 'package:meat_retailer/views/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meat Retailer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginView(),
        '/main': (context) => MainScreen(),
      },
    );
  }
}
