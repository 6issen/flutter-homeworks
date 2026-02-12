import 'package:dio/dio.dart';

class ErrorHandler {
  static String getMessage(DioException error) {
    // 1. Ошибки сети
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.connectionError) {
      return '📡 Нет соединения или сервер не отвечает.';
    }

    // 2. Отмена запроса
    if (error.type == DioExceptionType.cancel) {
      return '✋ Запрос был отменен пользователем.';
    }

    // 3. Ошибки от сервера (Response не null)
    if (error.response != null) {
      switch (error.response!.statusCode) {
        case 400:
          return '⚠️ Ошибка 400: Некорректный запрос.';
        case 401:
          return '🔒 Ошибка 401: Требуется авторизация.';
        case 403:
          return '🚫 Ошибка 403: Доступ запрещен.';
        case 404:
          return '🔍 Ошибка 404: Ресурс не найден.';
        case 500:
          return '🔥 Ошибка 500: Внутренняя ошибка сервера.';
        default:
          return '❓ Неизвестная ошибка: ${error.response!.statusCode}';
      }
    }

    return '🤷 Произошла непредвиденная ошибка.';
  }
}