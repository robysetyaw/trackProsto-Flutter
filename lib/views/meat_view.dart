import 'package:flutter/material.dart';
import '../models/meat.dart';
import '../services/meat_service.dart';

class MeatView extends StatefulWidget {
  @override
  _MeatViewState createState() => _MeatViewState();
}

class _MeatViewState extends State<MeatView> {
  final _meatService = MeatService();
  late Future<List<Meat>> _meatFuture;

  @override
  void initState() {
    super.initState();
    _meatFuture = _meatService.getMeats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meats'),
      ),
      body: FutureBuilder<List<Meat>>(
        future: _meatFuture,
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
                  title: Text(item.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Stock: ${item.stock.toString()}'),
                      Text('Price: ${item.price.toString()}'),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
