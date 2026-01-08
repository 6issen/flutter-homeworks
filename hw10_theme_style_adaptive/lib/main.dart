import 'package:flutter/material.dart';
import 'package:hw10_theme_style_adaptive/inheritated_app_theme.dart';
import 'package:hw10_theme_style_adaptive/screens/home_screen.dart';
import 'package:hw10_theme_style_adaptive/theme/app_theme.dart';
import 'package:hw10_theme_style_adaptive/theme_notifier.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _themeNotifier = ThemeNotifier();

  @override
  Widget build(BuildContext context) {
    return InheritatedAppTheme(
      themeNotifier: _themeNotifier,
      child: ListenableBuilder(
        listenable: _themeNotifier, 
        builder:(context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: _themeNotifier.value,
            home: const HomeScreen(),
            builder: (context, child) {
              return InheritatedAppTheme(
                themeNotifier: _themeNotifier,
                child: child!, 
                );
            },
          );
        },)
    );
  }
}
