import 'package:flutter/material.dart';
import 'package:hw12_spa_app/providers/expense_provider.dart';
import 'package:hw12_spa_app/screens/expense_detail_screen.dart';
import 'package:provider/provider.dart';
import 'add_expense_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseData = Provider.of<ExpenseProvider>(context);
    final expenses = expenseData.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои Расходы'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => const AddExpenseScreen()),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Column(
              children: [
                const Text('Всего потрачено:', style: TextStyle(fontSize: 16)),
                Text(
                  '${expenseData.totalAmount.toStringAsFixed(2)} ₸',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (ctx, i) => Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(child: Text('${expenses[i].amount}₸')),
                    ),
                  ),
                  title: Text(expenses[i].title),
                  subtitle: Text(expenses[i].category),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => expenseData.deleteExpense(expenses[i].id),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => ExpenseDetailScreen(expense: expenses[i]),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
