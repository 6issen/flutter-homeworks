import '../../domain/entities/note.dart';
import '../../domain/repositories/notes_repository.dart';
import '../datasources/notes_local_datasource.dart';
import '../datasources/notes_remote_datasource.dart';
import '../mappers/note_mapper.dart';

class NotesRepositoryImpl implements NotesRepository {
  final NotesRemoteDataSource remoteDataSource;
  final NotesLocalDataSource localDataSource;

  NotesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Stream<List<Note>> getNotes() async* {
    try {
      final cachedData = await localDataSource.getCachedNotes();
      if (cachedData.isNotEmpty) {
        yield cachedData.map((json) => NoteMapper.fromJson(json)).toList();
      }
    } catch (e) {
      // Игнорируем ошибки кэша, ждем данных с сервера
    }

    try {
      final remoteData = await remoteDataSource.fetchNotes();
      
      await localDataSource.saveNotes(remoteData);
      
      yield remoteData.map((json) => NoteMapper.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Ошибка загрузки данных: $e');
    }
  }
}