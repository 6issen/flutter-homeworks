import 'package:day_38_repository_adapter_mapping/data/mappers/note_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
// Путь зависит от имени твоего пакета, например:
// import 'package:my_app/data/mappers/note_mapper.dart'; 
// Для примера использую относительный:


void main() {
  group('NoteMapper Tests', () {
    test('Кейс 1: Нормальные данные парсятся корректно', () {
      final json = {'id': 1, 'title': 'Тест', 'content': 'Описание'};
      
      final note = NoteMapper.fromJson(json);

      expect(note.id, 1);
      expect(note.title, 'Тест');
      expect(note.content, 'Описание');
    });

    test('Кейс 2: Пустые или отсутствующие данные заменяются дефолтными', () {
      final json = {'id': 2}; // Нет title и content
      
      final note = NoteMapper.fromJson(json);

      expect(note.id, 2);
      expect(note.title, 'Без названия'); // Проверка дефолтного значения
      expect(note.content, '');
    });

    test('Кейс 3: Некорректные данные (нет ID) выбрасывают FormatException', () {
      final json = {'title': 'Только заголовок'};
      expect(() => NoteMapper.fromJson(json), throwsA(isA<FormatException>()));
    });
  });
}