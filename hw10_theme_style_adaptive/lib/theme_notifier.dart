import 'package:flutter/material.dart';

class ThemeNotifier extends ValueNotifier<ThemeMode>{
  ThemeNotifier({
    ThemeMode themeMode = ThemeMode.dark,
  }) : super(themeMode);

  void toggleMode(){
    value = value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }

}