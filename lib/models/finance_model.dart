class FinanceModel {
  String userId;
  double totalIncome;
  double totalExpenses;
  double savings;
  List<Expense> expenses;
  DateTime lastUpdated;

  FinanceModel({
    required this.userId,
    required this.totalIncome,
    required this.totalExpenses,
    required this.savings,
    required this.expenses,
    required this.lastUpdated,
  });

  /// Converts the FinanceModel instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'totalIncome': totalIncome,
      'totalExpenses': totalExpenses,
      'savings': savings,
      'expenses': expenses.map((e) => e.toJson()).toList(),
      'lastUpdated': lastUpdated.toIso8601String(),
    };
  }

  /// Creates a FinanceModel instance from a JSON object
  factory FinanceModel.fromJson(Map<String, dynamic> json) {
    return FinanceModel(
      userId: json['userId'],
      totalIncome: json['totalIncome'],
      totalExpenses: json['totalExpenses'],
      savings: json['savings'],
      expenses: (json['expenses'] as List)
          .map((e) => Expense.fromJson(e))
          .toList(),
      lastUpdated: DateTime.parse(json['lastUpdated']),
    );
  }
}

/// Represents a single expense entry
class Expense {
  String id;
  String category;
  String description;
  double amount;
  DateTime date;

  Expense({
    required this.id,
    required this.category,
    required this.description,
    required this.amount,
    required this.date,
  });

  /// Converts the Expense instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }

  /// Creates an Expense instance from a JSON object
  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      category: json['category'],
      description: json['description'],
      amount: json['amount'],
      date: DateTime.parse(json['date']),
    );
  }
}
