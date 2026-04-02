import 'package:flutter_test/flutter_test.dart';
// Обрати внимание на импорт: указываем имя проекта (в pubspec) и путь к файлу
import 'package:day_37_singleton_and_factory/utils/logger.dart';

void main() {
  group('Logger Singleton Tests', () {
    test('Должен возвращать один и тот же экземпляр при каждом вызове', () {
      // Act
      final logger1 = Logger();
      final logger2 = Logger();
      final logger3 = Logger();

      // Assert
      expect(logger1, same(logger2));
      expect(logger2, same(logger3));
      
      expect(identical(logger1, logger2), isTrue);
    });
  });
}