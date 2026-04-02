import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:day_39_unit_testing/domain/usecases/add_note_usecase.dart';
import 'package:day_39_unit_testing/domain/repositories/notes_repository.dart';
import 'package:day_39_unit_testing/domain/entities/note.dart';
import 'fixtures/note_fixtures.dart';
// 1. Создаем Мок-класс репозитория
class MockNotesRepository extends Mock implements NotesRepository {}

void main() {
  late AddNoteUseCase useCase;
  late MockNotesRepository mockRepository;

  // setUp вызывается перед каждым тестом (очищает состояние)
  setUp(() {
    mockRepository = MockNotesRepository();
    useCase = AddNoteUseCase(mockRepository);
    
    // Регистрируем fallback-значение для mocktail (нужно для работы с кастомными классами)
    registerFallbackValue(Note(id: 0, title: 'dummy', content: 'dummy'));
  });

  group('AddNoteUseCase Tests', () {
    test('Должен вызывать метод addNote у репозитория при корректных данных', () async {
      // Arrange (Подготовка): Настраиваем поведение мока
      when(() => mockRepository.addNote(any())).thenAnswer((_) async {});

      // Act (Действие): Вызываем UseCase
      await useCase.call(NoteFixtures.validNote);

      // Assert (Проверка): Убеждаемся, что репозиторий был вызван ровно 1 раз
      verify(() => mockRepository.addNote(NoteFixtures.validNote)).called(1);
    });

    test('Должен выбрасывать ArgumentError с нужным сообщением при пустом заголовке', () async {
      // Arrange
      final invalidNote = Note(id: 2, title: '   ', content: 'Текст'); // Пустой заголовок

      // Act & Assert
      // Проверяем, что вызов выбрасывает ошибку с ожидаемым текстом
      expect(
        () => useCase.call(invalidNote),
        throwsA(
          isA<ArgumentError>().having(
            (e) => e.message, 
            'message', 
            'Заголовок заметки не может быть пустым',
          ),
        ),
      );

      // Проверяем, что репозиторий НЕ был вызван, так как код упал до него
      verifyNever(() => mockRepository.addNote(any()));
    });
  });
}