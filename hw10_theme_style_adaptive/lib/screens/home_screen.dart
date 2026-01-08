import 'package:flutter/material.dart';
import 'package:hw10_theme_style_adaptive/inheritated_app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(
            'Theme',
            style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10.0),
            Switch.adaptive(value: InheritatedAppTheme.of(context).theme.value == ThemeMode.dark, onChanged: (value) {
              InheritatedAppTheme.of(context).theme.toggleMode();
            }),
            ...List.generate(10, (int index) {
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.2,
                child: Card(
                  child: Center(child: Text('Карточка номер ${(index+1)}')),
                ),
              );
              }),
            ],
          )
          ),
      ),
    );
  }
}