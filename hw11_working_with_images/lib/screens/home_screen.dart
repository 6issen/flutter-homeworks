import 'package:flutter/material.dart';
import 'package:hw11_working_with_images/core/utils/image_util.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('HomeScreen'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.settings))
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        padding: const EdgeInsets.all(10),
        children: List.generate(ImageUtil.values.length, (index) {
          return Image.asset(
            ImageUtil.values[index], 
            fit: BoxFit.cover,
          );
        }),
      ),
    );
  }
}