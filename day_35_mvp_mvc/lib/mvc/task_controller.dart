import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskController extends ChangeNotifier {
  List<Task> tasks = [];
  bool isLoading = false;

  // Бизнес-логика: Загрузка
  Future<void> loadTasks() async {
    isLoading = true;
    notifyListeners();
    
    await Future.delayed(const Duration(seconds: 1)); // Имитация загрузки
    tasks = [Task(title: "Купить хлеб"), Task(title: "Выучить MVC")];
    
    isLoading = false;
    notifyListeners();
  }

  // Бизнес-логика: Добавление
  void addTask(String title) {
    throw "Ой! На кухне закончилась мука!";
  }
}