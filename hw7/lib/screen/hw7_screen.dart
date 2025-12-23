import 'package:flutter/material.dart';
import 'package:hw7/controller/list_controller.dart';
import 'package:hw7/data/posts_model.dart';

class Homework7Page extends StatefulWidget {
  const Homework7Page({super.key});

  @override
  State<Homework7Page> createState() => _Homework7PageState();
}

class _Homework7PageState extends State<Homework7Page> {
  late Future<List<PostsModel>> _fetchPosts;

  @override
  void initState() {
    super.initState();
    _fetchPosts = ListController.fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("JSON Posts")),
      body: SafeArea(
        child: FutureBuilder(
          future: _fetchPosts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              final list = snapshot.data!;

              return ListView.separated(
                shrinkWrap: true,
                itemCount: list.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20.0),
                itemBuilder: (context, index) {
                  final item = list[index];
                  return Card(
                    color: Colors.teal,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'ID: ${item.id}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Tittle: ${item.title}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }

            return const Center(child: CircularProgressIndicator.adaptive());
          },
        ),
      ),
    );
  }
}
