import 'package:flutter/material.dart';
import '../models/finance_model.dart';
import '../services/database_service.dart';

class FinanceProvider with ChangeNotifier {
  List<Expense> _expenses = [];
  double _budget = 0.0;

  List<Expense> get expenses => _expenses;
  double get budget => _budget;

  Future<void> fetchFinanceData(String userId) async {
    _expenses = await DatabaseService.getExpenses(userId);
    _budget = await DatabaseService.getBudget(userId);
    notifyListeners();
  }

  Future<void> addExpense(Expense expense) async {
    await DatabaseService.addExpense(expense);
    _expenses.add(expense);
    notifyListeners();
  }

  Future<void> setBudget(double amount) async {
    await DatabaseService.updateBudget(amount);
    _budget = amount;
    notifyListeners();
  }

  Future<void> deleteExpense(String expenseId) async {
    await DatabaseService.deleteExpense(expenseId);
    _expenses.removeWhere((e) => e.id == expenseId);
    notifyListeners();
  }
}
