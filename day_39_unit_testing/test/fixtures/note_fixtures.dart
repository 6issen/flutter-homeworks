import 'package:day_39_unit_testing/domain/entities/note.dart';

class NoteFixtures {
  // 1. Идеальные данные
  static const Map<String, dynamic> validJson = {
    'id': 1, 'title': 'Купить хлеб', 'content': 'Белый'
  };
  
  // 2. Отсутствуют необязательные поля
  static const Map<String, dynamic> missingOptionalFieldsJson = {
    'id': 2
  };
  
  // 3. Пустые строки
  static const Map<String, dynamic> emptyStringsJson = {
    'id': 3, 'title': '', 'content': ''
  };
  
  // 4. Отсутствует обязательное поле (id)
  static const Map<String, dynamic> missingIdJson = {
    'title': 'Ошибка'
  };
  
  // 5. Неверный тип данных (id - строка вместо int)
  static const Map<String, dynamic> invalidTypeJson = {
    'id': 'это_строка', 'title': 'Тест'
  };

  // Готовая доменная сущность для тестов UseCase
  static final validNote = Note(id: 1, title: 'Купить хлеб', content: 'Белый');
}