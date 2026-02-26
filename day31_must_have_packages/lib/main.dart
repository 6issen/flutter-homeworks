import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/router/app_router.dart';

// Простой глобальный стейт для текущей локали
final appLocale = ValueNotifier<Locale>(const Locale('ru'));

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Инициализируем данные для форматирования дат пакетом intl
  await initializeDateFormatting('ru_RU', null);
  await initializeDateFormatting('en_US', null);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: appLocale,
      builder: (context, locale, _) {
        return MaterialApp.router(
          routerConfig: appRouter,
          locale: locale,
          // Настройки для поддержки разных языков в виджетах Material
          supportedLocales: const [Locale('en'), Locale('ru')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      }
    );
  }
}