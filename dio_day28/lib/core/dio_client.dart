import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'retry_interceptor.dart';

class DioClient {
  late final Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://httpbin.org', // Основной URL
        connectTimeout: const Duration(seconds: 5), // Таймаут соединения
        receiveTimeout: const Duration(seconds: 5), // Таймаут ответа
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Подключаем перехватчики
    dio.interceptors.addAll([
      // 1. Логирование (только в дебаге)
      if (kDebugMode)
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: (obj) => debugPrint('📝 DIO LOG: $obj'),
        ),
      
      // 2. Наш Retry Interceptor
      RetryInterceptor(dio: dio),
    ]);
  }
}