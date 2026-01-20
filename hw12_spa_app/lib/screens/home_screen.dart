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
        title: Text('Мои Расходы'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => AddExpenseScreen()),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, i) => Card(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
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
              icon: Icon(Icons.delete, color: Colors.red),
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
    );
  }
}