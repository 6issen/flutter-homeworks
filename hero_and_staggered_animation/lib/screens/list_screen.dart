import 'package:flutter/material.dart';
import 'details_screen.dart';
import 'animated_list_page.dart'; // Импорт примера AnimatedList

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  bool _isGridMode = false;

  final List<String> _images = [
    'https://picsum.photos/id/10/400/400',
    'https://picsum.photos/id/11/400/400',
    'https://picsum.photos/id/12/400/400',
    'https://picsum.photos/id/13/400/400',
    'https://picsum.photos/id/14/400/400',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gallery"),
        actions: [
          // Кнопка для перехода к демо AnimatedList
          IconButton(
            icon: const Icon(Icons.playlist_add_check),
            tooltip: "Demo AnimatedList",
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (_) => const AnimatedListPage())
              );
            },
          ),
          // Переключатель Grid/List с анимацией
          IconButton(
            onPressed: () => setState(() => _isGridMode = !_isGridMode),
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Icon(
                _isGridMode ? Icons.list : Icons.grid_view,
                key: ValueKey<bool>(_isGridMode),
              ),
            ),
          )
        ],
      ),
      body: _isGridMode
          ? GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _images.length,
              itemBuilder: (context, index) => _buildItem(index),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _images.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(height: 100, child: _buildItem(index)),
              ),
            ),
    );
  }

  Widget _buildItem(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(
              imageUrl: _images[index],
              tag: 'hero-tag-$index',
            ),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            // HERO START
            Hero(
              tag: 'hero-tag-$index',
              child: Image.network(
                _images[index],
                fit: BoxFit.cover,
                width: 100,
                height: double.infinity,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(child: Text("Item #${index+1} description")),
          ],
        ),
      ),
    );
  }
}