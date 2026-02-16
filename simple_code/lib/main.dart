import 'package:flutter/material.dart';
import 'package:simple_code/app_dependencies.dart';
import 'package:simple_code/domain/repos/task_repos.dart';

void main() {
  AppDependencies.fakeDependencies();
  runApp(const MyApp(instanceName: 'fake'));
}

class MyApp extends StatelessWidget {
  final String instanceName;

  const MyApp({
    super.key,
    required this.instanceName,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: HomePage(
        repository: AppDependencies.instance<TaskRepos>(instanceName: 'fake'),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
    required this.repository,
  });

  final TaskRepos repository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: repository.getInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == .waiting) {
            return Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.black,
              ),
            );
          }

          final data = snapshot.data!;

          return Center(
            child: Text('''
              Title: ${data.title},
              Descriptions: ${data.description},
            '''),
          );
        },
      ),
    );
  }
}