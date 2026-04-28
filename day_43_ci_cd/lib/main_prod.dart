import 'package:flutter/material.dart';
import 'app_config.dart';
import 'main.dart';

void main() {
  AppConfig.setConfig(AppConfig(
    appName: 'App PROD',
    baseUrl: 'https://api.example.com',
    environment: Environment.prod,
  ));
  runApp(const MyApp());
}
