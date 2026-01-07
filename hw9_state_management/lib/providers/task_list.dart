import 'package:flutter/material.dart';
import 'package:hw9_state_management/entity/task_entity.dart';

class TasksProvider extends ChangeNotifier {
  List<TaskEntity> tasks = [
    TaskEntity(title: 'Chelsea', description: 'Football Club', createdDate: DateTime.now()),
    TaskEntity(title: 'Manchester United', description: 'Football Club', createdDate: DateTime.now()),
    TaskEntity(title: 'Manchester City', description: 'Football Club', createdDate: DateTime.now())
  ];

  List<TaskEntity> get list => tasks;

  void addTask(TaskEntity task) {
    tasks.add(task);
    notifyListeners();
  }

  void removeTask() {
    tasks.removeLast();
    notifyListeners();
  }
}