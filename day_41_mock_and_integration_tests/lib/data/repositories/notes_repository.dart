import '../models/note.dart';
import '../services/api_client.dart';

class NotesRepository {
  final ApiClient apiClient;

  NotesRepository(this.apiClient);

  Future<List<Note>> getNotes() async {
    final rawNotes = await apiClient.getNotes();
    return rawNotes.map((json) => Note.fromJson(json)).toList();
  }

  Future<void> addNote(String title) async {
    await apiClient.addNote(title);
  }
}
