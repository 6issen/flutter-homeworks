import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/task_list_screen.dart';

void main() async {
  // Обязательно для асинхронной инициализации до запуска UI
  WidgetsFlutterBinding.ensureInitialized();

  // Подключаемся к Firebase, используя сгенерированный конфиг
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Tasks',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Пока мы не делали регистрацию (Auth), используем тестовый uid
      home: const TaskListScreen(currentUserId: 'test_user_123'),
    );
  }
}