import 'package:flutter/material.dart';
import 'package:hw6/data/tasks_model.dart';

class TasksListScreen extends StatefulWidget {
  const TasksListScreen({super.key});

  @override
  State<TasksListScreen> createState() => _TasksListScreenState();
}

class _TasksListScreenState extends State<TasksListScreen> {
  late final List<TasksModel> _tasksList;

  @override
  void initState() {
    super.initState();
    _tasksList = List.generate(20, (int index) {
      return TasksModel(
        title: 'Task number: ${index + 1}'
      );
    });
  }


  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks List'),
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: 
          ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 10),
            itemBuilder: (context, index) {
              final task = _tasksList[index];
              return Card(
                color: Colors.teal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(task.title,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      IconButton(onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Your clicked on ${task.title}'), duration: Duration(milliseconds: 800),)
                        );
                      }, icon: Icon(Icons.info_outline))
                    ],
                  )
                ),
              );
            }, 
            separatorBuilder: (context, index) => SizedBox(height: 10,), 
            itemCount: _tasksList.length,
          ),
      ),
    );
  }
}