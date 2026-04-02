import '../entities/note.dart';

abstract class NotesRepository {
  Stream<List<Note>> getNotes();
}