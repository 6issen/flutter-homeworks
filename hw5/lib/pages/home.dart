import 'package:flutter/material.dart';
import 'package:hw5/pages/details.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: 
        SafeArea(child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsPage(detailText: 'Привет из HomePage')));
              }, child: Text('Details'))
            ],
          )
        )
      )
    );
  }
}