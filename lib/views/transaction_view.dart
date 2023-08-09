import 'package:flutter/material.dart';
import 'package:meat_retailer/models/transaction.dart';
import 'package:meat_retailer/services/transaction_service.dart';

class TransactionView extends StatefulWidget {
  @override
  _TransactionViewState createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  final _transactionService = TransactionService();
  late Future<List<Transaction>> _transactionFuture;

  @override
  void initState() {
    super.initState();
    _transactionFuture = _transactionService.getAllTransactions();
  }

  void _showAddTransactionDialog() {
    final _formKey = GlobalKey<FormState>();
    String name = '';
    String txType = 'in';
    double paymentAmount = 0.0;
    // ... (Anda bisa menambahkan variabel lain untuk detail transaksi jika diperlukan)

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Transaction'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  onChanged: (value) => name = value,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) => value!.isEmpty ? "Name is required" : null,
                ),
                TextFormField(
                  onChanged: (value) => txType = value,
                  decoration: InputDecoration(labelText: 'Transaction Type'),
                ),
                TextFormField(
                  onChanged: (value) => paymentAmount = double.tryParse(value!) ?? 0.0,
                  decoration: InputDecoration(labelText: 'Payment Amount'),
                  keyboardType: TextInputType.number,
                ),
                // Tambahkan widget lain untuk input transaksi
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Add'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final transactionData = {
                    'name': name,
                    'tx_type': txType,
                    'payment_amount': paymentAmount,
                    // 'transaction_details': transactionDetails,
                  };
                  _transactionService.addTransaction(transactionData);
                  Navigator.of(context).pop();
                }
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
        title: Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: _transactionFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                final transaction = snapshot.data![index];
                return ListTile(
                  title: Text(transaction.invoiceNumber),
                  subtitle: Text(transaction.name),
                  trailing: Text(transaction.total.toString()),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTransactionDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
