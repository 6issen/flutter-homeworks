import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/firestore_service.dart';

class TaskListScreen extends StatefulWidget {
  final String currentUserId;

  const TaskListScreen({super.key, required this.currentUserId});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _titleController = TextEditingController(); // Для создания новой

  int _currentLimit = 10;
  String? _selectedCategory;
  String? _searchQuery;

  final List<String> _categories = ['Work', 'Personal', 'Home'];

  void _loadMore() {
    setState(() {
      _currentLimit += 10;
    });
  }

  // Диалог добавления задачи
  void _showAddTaskDialog() {
    String selectedCat = _categories.first;
    _titleController.clear();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            title: const Text('Add Task'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(hintText: 'Task title'),
                ),
                const SizedBox(height: 10),
                DropdownButton<String>(
                  value: selectedCat,
                  isExpanded: true,
                  items: _categories.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
                  onChanged: (val) {
                    if (val != null) setDialogState(() => selectedCat = val);
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_titleController.text.isNotEmpty) {
                    _firestoreService.addTask(
                      uid: widget.currentUserId,
                      title: _titleController.text,
                      category: selectedCat,
                    );
                    Navigator.pop(context);
                  }
                },
                child: const Text('Add'),
              ),
            ],
          );
        }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search tasks...',
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => setState(() => _searchQuery = _searchController.text),
                ),
              ),
              onSubmitted: (value) => setState(() => _searchQuery = value),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Фильтры
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: ['All', ..._categories].map((category) {
                final isSelected = _selectedCategory == category || (category == 'All' && _selectedCategory == null);
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category == 'All' ? null : category;
                        _currentLimit = 10; // Сброс пагинации
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          // Список задач
          Expanded(
            child: StreamBuilder<List<TaskModel>>(
              stream: _firestoreService.getTasksStream(
                uid: widget.currentUserId,
                limit: _currentLimit,
                categoryFilter: _selectedCategory,
                searchQuery: _searchQuery,
              ),
              builder: (context, snapshot) {
                // Обработка ошибки
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong.'));
                }

                // Загрузка
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final tasks = snapshot.data ?? [];

                // Пустое состояние
                if (tasks.isEmpty) {
                  return const Center(child: Text('No tasks found 📭'));
                }

                return ListView.builder(
                  itemCount: tasks.length + 1,
                  itemBuilder: (context, index) {
                    // Кнопка загрузки в самом низу
                    if (index == tasks.length) {
                      return tasks.length >= _currentLimit
                        ? TextButton(
                            onPressed: _loadMore,
                            child: const Text('Load More...'),
                          )
                        : const SizedBox(height: 20);
                    }

                    final task = tasks[index];
                    final isDone = task.status == 'completed';

                    return ListTile(
                      leading: Checkbox(
                        value: isDone,
                        onChanged: (val) {
                          _firestoreService.updateTaskStatus(task.id, val! ? 'completed' : 'active');
                        },
                      ),
                      title: Text(
                        task.title,
                        style: TextStyle(decoration: isDone ? TextDecoration.lineThrough : null),
                      ),
                      subtitle: Text(task.category),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () => _firestoreService.deleteTask(task.id),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}