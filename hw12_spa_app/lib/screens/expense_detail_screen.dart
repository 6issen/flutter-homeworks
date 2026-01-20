import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Добавьте пакет intl для форматирования дат
import '../models/expense.dart';

class ExpenseDetailScreen extends StatelessWidget {
  final Expense expense;

  const ExpenseDetailScreen({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(expense.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Сумма: ${expense.amount} ₸',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Chip(
              label: Text(expense.category),
              backgroundColor: Colors.indigo.withValues(alpha: 0.1),
            ),
            Divider(height: 40),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  'Дата: ${DateFormat('dd.MM.yyyy').format(expense.date)}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}