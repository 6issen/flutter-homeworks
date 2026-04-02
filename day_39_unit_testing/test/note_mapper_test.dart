import 'package:flutter_test/flutter_test.dart';
import 'package:day_39_unit_testing/data/mappers/note_mapper.dart';
import 'fixtures/note_fixtures.dart';

void main() {
  group('NoteMapper Tests (DTO -> Domain)', () {
    test('Кейс 1: Полные и корректные данные парсятся успешно', () {
      final note = NoteMapper.fromJson(NoteFixtures.validJson);
      expect(note.id, 1);
      expect(note.title, 'Купить хлеб');
    });

    test('Кейс 2: Отсутствующие необязательные поля заменяются дефолтными', () {
      final note = NoteMapper.fromJson(NoteFixtures.missingOptionalFieldsJson);
      expect(note.title, 'Без названия');
      expect(note.content, '');
    });

    test('Кейс 3: Пустые строки обрабатываются корректно', () {
      final note = NoteMapper.fromJson(NoteFixtures.emptyStringsJson);
      expect(note.title, '');
      expect(note.content, '');
    });

    test('Кейс 4: Отсутствие обязательного поля (id) выбрасывает FormatException', () {
      expect(
        () => NoteMapper.fromJson(NoteFixtures.missingIdJson),
        throwsA(isA<FormatException>()),
      );
    });

    test('Кейс 5: Неверный тип данных (id - String вместо int) выбрасывает TypeError', () {
      expect(
        () => NoteMapper.fromJson(NoteFixtures.invalidTypeJson),
        throwsA(isA<TypeError>()), 
      );
    });
  });
}