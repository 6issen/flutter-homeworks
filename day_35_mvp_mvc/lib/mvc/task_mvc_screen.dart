import 'package:flutter/material.dart';
import 'task_controller.dart';
import '../core/error_handler.dart';

class TaskMvcScreen extends StatefulWidget {
  @override
  _TaskMvcScreenState createState() => _TaskMvcScreenState();
}

class _TaskMvcScreenState extends State<TaskMvcScreen> {
  final TaskController _controller = TaskController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
    _controller.loadTasks().catchError((e) => ErrorHandler.handle(context, e));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MVC Tasks")),
      body: _controller.isLoading 
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: _controller.tasks.length,
            itemBuilder: (context, i) => ListTile(title: Text(_controller.tasks[i].title)),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          try {
            _controller.addTask("Новая задача MVC");
          } catch (e) {
            ErrorHandler.handle(context, e);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}