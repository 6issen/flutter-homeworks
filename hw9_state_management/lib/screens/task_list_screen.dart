import 'package:flutter/material.dart';
import 'package:hw9_state_management/entity/task_entity.dart';
import 'package:hw9_state_management/providers/task_list.dart';
import 'package:hw9_state_management/widgets/task_button_widget.dart';
import 'package:hw9_state_management/widgets/task_card_widget.dart';
import 'package:provider/provider.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TasksProvider(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text("Task List"),
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
              centerTitle: true,
              ),
              bottomNavigationBar: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      Expanded(child: TaskButton(title: 'Remove task', onPressed: () => context.read<TasksProvider>().removeTask(),)),
                      const SizedBox(width: 6.0),
                      Expanded(child: TaskButton(title: 'Add task',onPressed: () => context.read<TasksProvider>().addTask(TaskEntity(title: 'Arsenal', description: 'Football Club', createdDate: DateTime.now())))),
                    ],
                  )
                )
                ),
            body: 
              SafeArea(
                child: Consumer<TasksProvider>(
                  builder: (context, value, child) {
                    final list = value.list;
          
                    if (list.isEmpty) {
                      return Center(
                        child: Text('Task list is empty!', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
                      );
                    }
          
                    return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    itemBuilder: (context, index) {
                      final item = list[index];
                      return TaskCard(item: item);
                    }, 
                    separatorBuilder: (context, index) => const SizedBox(height: 6.0,), 
                    itemCount: list.length,
                  );
                  },
                ),
              ),
          );
        }
        )
    );
  }
}


