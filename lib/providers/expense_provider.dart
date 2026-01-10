import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/expense.dart';

class ExpenseProvider extends ChangeNotifier {
  static const String _storageKey = 'expenses';

  List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  ExpenseProvider() {
    _loadExpensesFromStorage();
  }

  // -------------------------------
  // Add Expense
  // -------------------------------
  void addExpense(Expense expense) {
    _expenses.add(expense);
    _saveExpensesToStorage();
    notifyListeners();
  }

  // -------------------------------
  // Update or Add Expense
  // -------------------------------
  void addOrUpdateExpense(Expense expense) {
    final index = _expenses.indexWhere((e) => e.id == expense.id);

    if (index >= 0) {
      _expenses[index] = expense;
    } else {
      _expenses.add(expense);
    }

    _saveExpensesToStorage();
    notifyListeners();
  }

  // -------------------------------
  // Remove Expense
  // -------------------------------
  void removeExpense(String id) {
    _expenses.removeWhere((e) => e.id == id);
    _saveExpensesToStorage();
    notifyListeners();
  }

  // -------------------------------
  // Load Expenses from SharedPreferences
  // -------------------------------
  Future<void> _loadExpensesFromStorage() async {
    final prefs = await SharedPreferences.getInstance();

    final String? jsonString = prefs.getString(_storageKey);

    if (jsonString == null) return;

    final List decodedList = json.decode(jsonString);

    _expenses = decodedList
        .map((e) => Expense.fromJson(
              Map<String, dynamic>.from(e),
            ))
        .toList();

    notifyListeners();
  }

  // -------------------------------
  // Save Expenses to SharedPreferences
  // -------------------------------
  Future<void> _saveExpensesToStorage() async {
    final prefs = await SharedPreferences.getInstance();

    final String jsonString =
        json.encode(_expenses.map((e) => e.toJson()).toList());

    await prefs.setString(_storageKey, jsonString);
  }
}
