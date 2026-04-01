import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
    });
  }

  Future<void> _toggleNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', value);
    
    setState(() {
      _notificationsEnabled = value;
    });

    if (value) {
      // Если включили, переподписываемся (получаем токен)
      // В реальном проекте здесь вызов метода из сервиса
      FirebaseMessaging.instance.getToken();
    } else {
      // Если выключили, удаляем токен, чтобы сервер нам ничего не слал
      await FirebaseMessaging.instance.deleteToken();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Enable Push Notifications'),
            subtitle: const Text('Receive alerts and updates'),
            value: _notificationsEnabled,
            onChanged: _toggleNotifications,
          ),
        ],
      ),
    );
  }
}