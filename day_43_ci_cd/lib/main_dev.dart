import 'package:flutter/material.dart';
import 'app_config.dart';
import 'main.dart';

void main() {
  AppConfig.setConfig(AppConfig(
    appName: 'App DEV',
    baseUrl: 'https://dev.api.example.com',
    environment: Environment.dev,
  ));
  runApp(const MyApp());
}
