class Transaction {
  final String id;
  final DateTime date;
  final String invoiceNumber;
  final String name;
  final String address;
  final String company;
  final String phoneNumber;
  final String txType;
  final String paymentStatus;
  final double paymentAmount;
  final double total;
  final double debt;
  final dynamic transactionDetails;

  Transaction({
    required this.id,
    required this.date,
    required this.invoiceNumber,
    required this.name,
    required this.address,
    required this.company,
    required this.phoneNumber,
    required this.txType,
    required this.paymentStatus,
    required this.paymentAmount,
    required this.total,
    required this.debt,
    required this.transactionDetails,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      date: DateTime.parse(json['date']),
      invoiceNumber: json['invoice_number'],
      name: json['name'],
      address: json['address'],
      company: json['company'],
      phoneNumber: json['phone_number'],
      txType: json['tx_type'],
      paymentStatus: json['payment_status'],
      paymentAmount: double.parse(json['payment_amount'].toString()),
      total: double.parse(json['total'].toString()),
      debt: double.parse(json['Debt'].toString()),
      transactionDetails: json['transaction_details'],
    );
  }
}
