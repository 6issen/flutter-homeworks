import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../main.dart'; // для navigatorKey

class FCMService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // 1. Запрос разрешений
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
      
      // Проверяем локальную настройку (включены ли пуши юзером)
      final prefs = await SharedPreferences.getInstance();
      final isEnabled = prefs.getBool('notifications_enabled') ?? true;
      
      if (isEnabled) {
        await _setupToken();
      }

      await _setupLocalNotifications();
      _setupInteractions();
    }
  }

  // 2. Получение и сохранение токена
  static Future<void> _setupToken() async {
    try {
      String? token = await _messaging.getToken();
      if (token != null) {
        await _saveTokenToFirestore(token);
      }

      // Слушаем обновление токена
      _messaging.onTokenRefresh.listen(_saveTokenToFirestore);
    } catch (e) {
      debugPrint("Error getting token: $e");
    }
  }

  static Future<void> _saveTokenToFirestore(String token) async {
    // В реальном приложении здесь будет ID авторизованного пользователя
    const String userId = 'test_user_123'; 
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'fcmToken': token,
      'lastUpdated': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
    debugPrint("Token saved: $token");
  }

  // 3. Настройка локальных уведомлений (для Foreground)
  static Future<void> _setupLocalNotifications() async {
    const androidInit = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    await _localNotifications.initialize(
      settings: androidInit, // <-- Поменяли название параметра здесь
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        if (response.payload != null) {
          final data = jsonDecode(response.payload!);
          _handleNavigation(data);
        }
      },
    );
  }

  // 4. Обработка получения и кликов
  static void _setupInteractions() {
    // А) Приложение открыто (Foreground). Сами показываем уведомление.
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("Got message in foreground: ${message.data}");
      _showLocalNotification(message);
    });

    // Б) Клик по пушу, когда приложение было свернуто (Background)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("Notification clicked from background");
      _handleNavigation(message.data);
    });

    // В) Клик по пушу, когда приложение было убито (Terminated)
    _messaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        debugPrint("Notification clicked from terminated state");
        // Небольшая задержка, чтобы UI успел отрисоваться
        Future.delayed(const Duration(milliseconds: 500), () {
          _handleNavigation(message.data);
        });
      }
    });
  }

  static void _showLocalNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    if (notification != null) {
      _localNotifications.show(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
        payload: jsonEncode(message.data),
      );
    }
  }

  // 5. Логика Deep Link (открытие экрана по payload)
  static void _handleNavigation(Map<String, dynamic> data) {
    if (data.containsKey('itemId')) {
      final itemId = data['itemId'];
      // Используем глобальный ключ для перехода
      navigatorKey.currentState?.pushNamed(
        '/details',
        arguments: itemId,
      );
    }
  }
}