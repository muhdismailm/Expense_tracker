class Expense {
  String id;
  String payee;
  double amount;
  String notes;
  DateTime date;
  String categoryId;
  String tagId;

  Expense({
    required this.id,
    required this.payee,
    required this.amount,
    required this.notes,
    required this.date,
    required this.categoryId,
    required this.tagId,
  });

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        id: json['id'],
        payee: json['payee'],
        amount: json['amount'],
        notes: json['notes'],
        date: DateTime.parse(json['date']),
        categoryId: json['categoryId'],
        tagId: json['tagId'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'payee': payee,
        'amount': amount,
        'notes': notes,
        'date': date.toIso8601String(),
        'categoryId': categoryId,
        'tagId': tagId,
      };
}
