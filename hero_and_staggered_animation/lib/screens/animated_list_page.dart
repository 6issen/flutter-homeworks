import 'package:flutter/material.dart';

class AnimatedListPage extends StatefulWidget {
  const AnimatedListPage({super.key});

  @override
  State<AnimatedListPage> createState() => _AnimatedListPageState();
}

class _AnimatedListPageState extends State<AnimatedListPage> {
  // Глобальный ключ для управления состоянием AnimatedList
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  
  // Наши данные
  final List<String> _data = ["Элемент 1", "Элемент 2", "Элемент 3"];

  void _addItem() {
    final int index = 0; // Добавляем в начало
    _data.insert(index, "Новый элемент ${DateTime.now().second}");
    _listKey.currentState?.insertItem(index);
  }

  void _removeItem(int index) {
    final removedItem = _data.removeAt(index);
    
    // Анимация удаления требует builder, который отрисует исчезающий элемент
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildItem(removedItem, animation, onDelete: null),
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Animated List Demo")),
      floatingActionButton: FloatingActionButton(
        onPressed: _addItem,
        child: const Icon(Icons.add),
      ),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _data.length,
        itemBuilder: (context, index, animation) {
          return _buildItem(_data[index], animation, onDelete: () => _removeItem(index));
        },
      ),
    );
  }

  Widget _buildItem(String item, Animation<double> animation, {VoidCallback? onDelete}) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        color: Colors.orangeAccent.shade100,
        child: ListTile(
          title: Text(item),
          trailing: onDelete != null
              ? IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: onDelete,
                )
              : null,
        ),
      ),
    );
  }
}