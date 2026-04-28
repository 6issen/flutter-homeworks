import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/expense_provider.dart';
import './screens/home_screen.dart';

void main() {
  runApp(
    // Провайдер ДОЛЖЕН быть выше, чем MaterialApp
    ChangeNotifierProvider(
      create: (context) => ExpenseProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomeScreen(), // Теперь HomeScreen увидит провайдера выше по дереву
    );
  }
}

// 1.Архитектура: Добавил расчет totalAmount в провайдер (бизнес-логика вынесена из UI).
// 2.UI: Добавил карточку общего баланса на главный экран и улучшил форму добавления.
// 3.Фичи: Реализовал динамический выбор категорий вместо хардкода.