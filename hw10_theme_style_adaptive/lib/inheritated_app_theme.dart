import 'package:flutter/material.dart';
import 'package:hw10_theme_style_adaptive/theme_notifier.dart';

class InheritatedAppTheme extends InheritedWidget {
  const InheritatedAppTheme({
    super.key ,
    required super.child,
    required ThemeNotifier themeNotifier,
    }) : _themeMode = themeNotifier;

  final ThemeNotifier _themeMode;

  ThemeNotifier get theme => _themeMode;

  static InheritatedAppTheme of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<InheritatedAppTheme>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritatedAppTheme oldWidget) {
    return oldWidget._themeMode != _themeMode;
  }

}