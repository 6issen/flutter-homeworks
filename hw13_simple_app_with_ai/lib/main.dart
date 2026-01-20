import 'dart:developer';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SimpleFormScreen(),
    );
  }
}

class SimpleFormScreen extends StatefulWidget {
  const SimpleFormScreen({super.key});

  @override
  State<SimpleFormScreen> createState() => _SimpleFormScreenState();
}

class _SimpleFormScreenState extends State<SimpleFormScreen> {
  // Контроллеры позволяют получать текст из полей
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();

  @override
  void dispose() {
    // Важно освобождать ресурсы контроллеров
    _firstController.dispose();
    _secondController.dispose();
    super.dispose();
  }

  void _handlePress() {
    // Логика при нажатии на кнопку
    log('Поле 1: ${_firstController.text}');
    log('Поле 2: ${_secondController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Простая форма'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _firstController,
              decoration: const InputDecoration(
                labelText: 'Введите имя',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16), // Отступ между полями
            TextField(
              controller: _secondController,
              decoration: const InputDecoration(
                labelText: 'Введите фамилию',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity, // Кнопка на всю ширину
              height: 50,
              child: ElevatedButton(
                onPressed: _handlePress,
                child: const Text('Отправить'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}