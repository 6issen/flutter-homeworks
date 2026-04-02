import 'package:flutter/foundation.dart';

class Logger {
  // Приватный именованный конструктор
  Logger._internal();

  // Единственный экземпляр класса
  static final Logger _instance = Logger._internal();

  // Фабричный конструктор всегда возвращает один и тот же экземпляр
  factory Logger() {
    return _instance;
  }

  void log(String message) {
    final time = DateTime.now().toIso8601String();
    debugPrint('[$time] LOG: $message');
  }
}