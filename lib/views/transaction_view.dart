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
                  subtitle: Text(transaction.name + ", " + transaction.company),
                  trailing: Text(transaction.total.toString()),
                );
              },
            );
          }
        },
      ),
    );
  }
}
