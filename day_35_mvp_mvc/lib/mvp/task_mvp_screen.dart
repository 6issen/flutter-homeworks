import 'package:flutter/material.dart';
import 'task_presenter.dart';
import '../models/task.dart';
import '../core/error_handler.dart';

class TaskMvpScreen extends StatefulWidget {
  @override
  _TaskMvpScreenState createState() => _TaskMvpScreenState();
}

class _TaskMvpScreenState extends State<TaskMvpScreen> implements TaskViewContract {
  late TaskPresenter _presenter;
  List<Task> _tasks = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _presenter = TaskPresenter(this);
    _presenter.loadTasks();
  }

  // Реализация методов контракта
  @override void showLoading() => setState(() => _isLoading = true);
  @override void hideLoading() => setState(() => _isLoading = false);
  @override void updateList(List<Task> tasks) => setState(() => _tasks = tasks);
  @override void showError(String msg) => ErrorHandler.handle(context, msg);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MVP Tasks")),
      body: _isLoading 
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: _tasks.length,
            itemBuilder: (context, i) => ListTile(title: Text(_tasks[i].title)),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _presenter.addTask("Задача из MVP"),
        child: Icon(Icons.add),
      ),
    );
  }
}