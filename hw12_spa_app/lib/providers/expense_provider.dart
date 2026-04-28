import 'package:flutter/material.dart';
import '../models/expense.dart';

class ExpenseProvider with ChangeNotifier {
  final List<Expense> _items = [
    Expense(id: '1', title: 'Кофе', amount: 250, date: DateTime.now(), category: 'Еда'),
    Expense(id: '2', title: 'Метро', amount: 50, date: DateTime.now(), category: 'Транспорт'),
  ];

  List<Expense> get items => [..._items];

  double get totalAmount {
    return _items.fold(0.0, (sum, item) => sum + item.amount);
  }

  void addExpense(Expense expense) {
    _items.add(expense);
    notifyListeners();
  }

  void deleteExpense(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }
}