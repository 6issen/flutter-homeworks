import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'services/fcm_service.dart';
import 'screens/settings_screen.dart';
import 'screens/notification_details_screen.dart';

// Глобальный ключ для навигации без контекста
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Обязательный глобальный обработчик для Terminated/Background состояний
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  debugPrint("Handling a background message: ${message.messageId}");
  // Здесь можно залогировать получение в аналитику
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  
  // Инициализируем наш сервис уведомлений
  FCMService.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Push Demo',
      routes: {
        '/': (context) => const SettingsScreen(),
        '/details': (context) => const NotificationDetailsScreen(),
      },
    );
  }
}