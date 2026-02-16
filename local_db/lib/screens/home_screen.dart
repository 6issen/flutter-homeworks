import 'package:flutter/material.dart';
import 'package:drift/drift.dart' as drift;
import 'package:local_db/data/local_database.dart';


class HomeScreen extends StatefulWidget {
  final AppDatabase database;
  const HomeScreen({super.key, required this.database});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // true = режим Watch (авто), false = режим Get (ручной)
  bool isStreamMode = true; 
  List<TaskWithTag> manualTasks = [];

  @override
  void initState() {
    super.initState();
    if (!isStreamMode) _loadData();
  }

  Future<void> _loadData() async {
    final data = await widget.database.getAllTasks();
    setState(() => manualTasks = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Задачи"),
        actions: [
          Row(children: [
            Text(isStreamMode ? "Auto" : "Manual", style: const TextStyle(fontSize: 12)),
            Switch(
              value: isStreamMode,
              onChanged: (val) {
                setState(() => isStreamMode = val);
                if (!val) _loadData();
              },
            ),
          ]),
          if (!isStreamMode)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _loadData,
            )
        ],
      ),
      body: isStreamMode ? _buildStreamList() : _buildManualList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStreamList() {
    return StreamBuilder<List<TaskWithTag>>(
      stream: widget.database.watchAllTasks(),
      builder: (context, snapshot) {
        if (snapshot.hasData) return _buildList(snapshot.data!);
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildManualList() {
    return _buildList(manualTasks);
  }

  Widget _buildList(List<TaskWithTag> items) {
    if (items.isEmpty) return const Center(child: Text("Нет задач"));

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Dismissible(
          key: Key(item.task.id.toString()),
          background: Container(
            color: Colors.red,
            // 1. Выравниваем содержимое контейнера по правому центру
            alignment: Alignment.centerRight, 
            // 2. Добавляем немного отступа справа, чтобы иконка не прилипала к краю
            padding: const EdgeInsets.only(right: 20.0), 
            // 3. Сама иконка
            child: const Icon(
              Icons.delete,
              color: Colors.white, // Белая иконка на красном фоне смотрится хорошо
            ),
          ),
          onDismissed: (_) => widget.database.deleteTask(item.task),
          child: ListTile(
            title: Text(item.task.title),
            subtitle: Text(item.task.priority > 0 ? "🔥 Высокий приоритет" : "Обычный"),
            // При нажатии меняем приоритет
            onTap: () {
              final newPriority = item.task.priority == 0 ? 1 : 0;
              widget.database.updateTask(item.task.copyWith(priority: newPriority));
              
              if (!isStreamMode) {
                 ScaffoldMessenger.of(context).showSnackBar(
                   const SnackBar(content: Text("Обновите список вручную!")),
                 );
              }
            },
          ),
        );
      },
    );
  }

  // --- ДОБАВЛЕНИЕ ---

  void _showAddTaskDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Новая задача"),
        content: TextField(
          controller: controller,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () async {
              if (controller.text.isNotEmpty) {
                await widget.database.addTask(
                  TaskItemsCompanion(
                    title: drift.Value(controller.text),
                    dueDate: drift.Value(DateTime.now()),
                  ),
                );

                // --- ИСПРАВЛЕНИЕ ОШИБКИ ЛИНТЕРА ---
                if (!context.mounted) return;
                // ignore: use_build_context_synchronously
                Navigator.pop(context); // Закрываем диалог

                // Если ручной режим, подсказываем обновить
                if (!isStreamMode && context.mounted) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Нажмите кнопку обновления сверху")),
                  );
                }
              }
            },
            child: const Text("Добавить"),
          )
        ],
      ),
    );
  }
}