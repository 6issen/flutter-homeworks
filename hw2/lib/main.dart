import 'dart:developer';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: StartPage(),
    );
  }
}

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Добро пожаловать во Flutter!'),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.all(Radius.circular(50.0)),
                child: Image.network(
                  "https://cdn.wallpapersafari.com/64/1/OrjeEY.jpg",
                ),
              )
            ),
            ElevatedButton(onPressed: () {
              log('Clicked!!');
            }, child: Text('Click me')),
          ],
        ),
      ),
    );
  }
}