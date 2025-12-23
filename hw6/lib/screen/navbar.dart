import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: NavigationBar(
                destinations: [
                  NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
                  NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
                  NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
                ]
              ),
      body: SafeArea(
        child: Center(
          child: Row(
            children: [
              
            ],
          ),
        ),
        ),
    );
  }
}