import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final int _retryIntervalMs = 1000; // 1 секунда

  RetryInterceptor({required this.dio, this.maxRetries = 2});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Проверяем, стоит ли повторять (таймауты или ошибки соединения)
    if (_shouldRetry(err) && (err.requestOptions.extra['retries'] ?? 0) < maxRetries) {
      int retries = err.requestOptions.extra['retries'] ?? 0;
      retries++;
      
      // Ждем перед повтором
      await Future.delayed(Duration(milliseconds: _retryIntervalMs));
      
      // Обновляем счетчик
      err.requestOptions.extra['retries'] = retries;
      
      try {
        debugPrint('🔄 RETRY: Попытка №$retries для ${err.requestOptions.path}');
        // Повторяем запрос
        final response = await dio.fetch(err.requestOptions);
        return handler.resolve(response);
      } catch (e) {
        return handler.next(err); // Если снова ошибка, пробрасываем её
      }
    }
    return handler.next(err);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
           err.type == DioExceptionType.receiveTimeout ||
           err.type == DioExceptionType.connectionError;
  }
}