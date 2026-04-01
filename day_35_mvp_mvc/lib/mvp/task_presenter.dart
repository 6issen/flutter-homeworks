import '../models/task.dart';

// Описываем, что должен уметь экран
abstract class TaskViewContract {
  void showLoading();
  void hideLoading();
  void updateList(List<Task> tasks);
  void showError(String msg);
}

class TaskPresenter {
  final TaskViewContract _view;
  List<Task> _tasks = [];

  TaskPresenter(this._view);

  Future<void> loadTasks() async {
    _view.showLoading();
    await Future.delayed(const Duration(seconds: 1));
    _tasks = [Task(title: "Купить молоко"), Task(title: "Выучить MVP")];
    _view.updateList(_tasks);
    _view.hideLoading();
  }

  void addTask(String title) {
    if (title.isEmpty) {
      _view.showError("Пустое название!");
      return;
    }
    _tasks.add(Task(title: title));
    _view.updateList(_tasks);
  }
}