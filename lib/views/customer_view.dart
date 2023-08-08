import 'package:flutter/material.dart';
import '../models/customer.dart';
import '../services/customer_service.dart';

class CustomerView extends StatefulWidget {
  @override
  _CustomerViewState createState() => _CustomerViewState();
}

class _CustomerViewState extends State<CustomerView> {
  final _customerService = CustomerService();
  late Future<List<Customer>> _customerFuture;

  // Variables to hold form data
  final _fullnameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _companyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _customerFuture = _customerService.getCustomers();
  }

  // Method to show the add customer form
  Future<void> _showAddCustomerDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Customer'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: _fullnameController,
                  decoration: InputDecoration(hintText: "Full Name"),
                ),
                TextField(
                  controller: _addressController,
                  decoration: InputDecoration(hintText: "Address"),
                ),
                TextField(
                  controller: _phoneNumberController,
                  decoration: InputDecoration(hintText: "Phone Number"),
                ),
                TextField(
                  controller: _companyController,
                  decoration: InputDecoration(hintText: "Company"),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Submit'),
              onPressed: () {
                _customerService.addCustomer(
                  _fullnameController.text,
                  _addressController.text,
                  _phoneNumberController.text,
                  _companyController.text,
                );
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
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
        title: Text('Customers'),
      ),
      body: FutureBuilder<List<Customer>>(
        future: _customerFuture,
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
                  title: Text(item.fullname),
                  subtitle: Text('Phone: ${item.phoneNumber}\nAddress: ${item.address}'),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddCustomerDialog,
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
