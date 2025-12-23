import 'package:flutter/material.dart';
import 'package:hw5/pages/settings.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.detailText});

  final String detailText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: 
        SafeArea(
          child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(detailText),
              const SizedBox(height: 20,),
              ElevatedButton(onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => const SettingsPage(),
                  )
                );
              }, child: Text('Settings')),
            ],
          )
          )
        )
      );
  }
}