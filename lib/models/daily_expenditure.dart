class DailyExpenditure {
  final String id;
  final String userId;
  final String deNote;
  final double amount;
  final String description;
  final DateTime date;

  DailyExpenditure({
    required this.id,
    required this.userId,
    required this.deNote,
    required this.amount,
    required this.description,
    required this.date,
  });

  factory DailyExpenditure.fromJson(Map<String, dynamic> json) {
    return DailyExpenditure(
      id: json['id'],
      userId: json['user_id'],
      deNote: json['de_note'],
      amount: json['amount'].toDouble(),
      description: json['description'],
      date: DateTime.parse(json['date']),
    );
  }
}
