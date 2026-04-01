import 'package:flutter/material.dart';

class ErrorHandler {
  static void handle(BuildContext context, dynamic error) {
    String message = "Произошла ошибка";
    
    if (error is String) message = error;
    if (error is Exception) message = "Ошибка сети или данных";

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }
}