import 'package:flutter/material.dart';

enum WidgetStatus { loading, success, error }

class StatusWidgetFactory {
  static Widget create(WidgetStatus status) {
    switch (status) {
      case WidgetStatus.loading:
        return const CircularProgressIndicator();
      case WidgetStatus.success:
        return const Icon(Icons.check_circle, color: Colors.green, size: 50);
      case WidgetStatus.error:
        return const Icon(Icons.error, color: Colors.red, size: 50);
    }
  }
}