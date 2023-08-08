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

  void addMeat() {
  String name = '';
  String stock = '';
  String price = '';

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add New Meat'),
        content: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                name = value;
              },
              decoration: InputDecoration(hintText: "Name"),
            ),
            TextField(
              onChanged: (value) {
                stock = value;
              },
              decoration: InputDecoration(hintText: "Stock"),
            ),
            TextField(
              onChanged: (value) {
                price = value;
              },
              decoration: InputDecoration(hintText: "Price"),
            ),
          ],
        ),
        actions: <Widget>[
          ElevatedButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: Text('Submit'),
            onPressed: () async {
              // TODO: Call the service to add the new meat
              // You might want to check for input validation before calling the service
              // Here we are directly passing the entered values which might lead to exception if the values are not correct
              bool success = await _meatService.addMeat(name, double.parse(stock), double.parse(price));
              if (success) {
                // Refresh the meat list
                Navigator.pop(context); // menutup form setelah permintaan berhasil
                setState(() {
                  _meatFuture = _meatService.getMeats();
                });
                Navigator.of(context).pop();
              } else {
                // Show error message
                // Handle your error here
              }
            },
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meat'),
      ),
      body: FutureBuilder<List<Meat>>(
        future: _meatFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('Stock: ${item.stock} - Price: ${item.price}'),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addMeat,  // Memanggil fungsi addMeat() saat ditekan
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}
