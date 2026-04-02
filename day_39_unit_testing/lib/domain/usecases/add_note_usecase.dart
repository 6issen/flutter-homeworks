import 'package:day_39_unit_testing/domain/entities/note.dart';
import 'package:day_39_unit_testing/domain/repositories/notes_repository.dart';

class AddNoteUseCase {
  final NotesRepository repository;

  AddNoteUseCase(this.repository);

  Future<void> call(Note note) async {
    // Бизнес-логика: валидация перед отправкой в репозиторий
    if (note.title.trim().isEmpty) {
      throw ArgumentError('Заголовок заметки не может быть пустым');
    }
    
    // Делегируем сохранение репозиторию
    await repository.addNote(note);
  }
}