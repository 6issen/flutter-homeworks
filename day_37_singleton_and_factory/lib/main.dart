import 'package:flutter/material.dart';
import 'utils/logger.dart';
import 'models/api_response.dart';
import 'widgets/status_widget_factory.dart';

void main() {
  // Используем Singleton (Место 1)
  Logger().log('App is starting...');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DemoScreen(),
    );
  }
}

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  WidgetStatus _currentStatus = WidgetStatus.success;

  @override
  void initState() {
    super.initState();
    // Используем Singleton (Место 2)
    Logger().log('DemoScreen initialized');
    _simulateApiCall();
  }

  void _simulateApiCall() {
    // Имитация ответа от API
    final jsonResponse = {'type': 'text', 'content': 'Привет от сервера!'};
    final parsedResponse = ApiResponse.fromJson(jsonResponse);

    if (parsedResponse is TextResponse) {
      Logger().log('Parsed API response: ${parsedResponse.content}');
    }
  }

  void _changeStatus() {
    // Используем Singleton (Место 3)
    Logger().log('Changing status to Error');
    setState(() {
      _currentStatus = WidgetStatus.error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Design Patterns Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Используем Factory для виджетов
            StatusWidgetFactory.create(_currentStatus),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changeStatus,
              child: const Text('Показать ошибку'),
            ),
          ],
        ),
      ),
    );
  }
}