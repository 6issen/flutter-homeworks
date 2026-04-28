import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:day_41_mock_and_integration_tests/data/repositories/notes_repository.dart';
import 'package:day_41_mock_and_integration_tests/data/services/api_client.dart';
import 'package:day_41_mock_and_integration_tests/data/models/note.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late NotesRepository repository;
  late MockApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockApiClient();
    repository = NotesRepository(mockApiClient);
  });

  group('NotesRepository', () {
    test('getNotes should return a list of Note objects when ApiClient returns raw data', () async {
      // Arrange
      final rawNotes = [
        {'id': 1, 'title': 'Note 1'},
        {'id': 2, 'title': 'Note 2'},
      ];
      when(() => mockApiClient.getNotes()).thenAnswer((_) async => rawNotes);

      // Act
      final result = await repository.getNotes();

      // Assert
      expect(result, isA<List<Note>>());
      expect(result.length, 2);
      expect(result[0].title, 'Note 1');
      expect(result[1].id, 2);
      verify(() => mockApiClient.getNotes()).called(1);
    });

    test('addNote should call ApiClient.addNote with correct title', () async {
      // Arrange
      const title = 'New Note';
      when(() => mockApiClient.addNote(any())).thenAnswer((_) async => {});

      // Act
      await repository.addNote(title);

      // Assert
      verify(() => mockApiClient.addNote(title)).called(1);
    });

    test('getNotes should throw an exception when ApiClient fails', () async {
      // Arrange
      when(() => mockApiClient.getNotes()).thenThrow(Exception('Network error'));

      // Act & Assert
      expect(() => repository.getNotes(), throwsException);
    });
  });
}
