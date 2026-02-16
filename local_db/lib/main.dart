import 'package:flutter/material.dart';
import 'data/local_database.dart'; // Импорт базы
import 'screens/home_screen.dart';      // Импорт экрана

void main() {
  // Инициализируем базу один раз при старте
  final database = AppDatabase();
  
  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final AppDatabase database;

  const MyApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Drift Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(database: database),
    );
  }
}