abstract class NotesLocalDataSource {
  Future<List<Map<String, dynamic>>> getCachedNotes();
  Future<void> saveNotes(List<Map<String, dynamic>> notes);
}

class NotesLocalDataSourceImpl implements NotesLocalDataSource {
  List<Map<String, dynamic>> _mockCache = [];

  @override
  Future<List<Map<String, dynamic>>> getCachedNotes() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _mockCache;
  }

  @override
  Future<void> saveNotes(List<Map<String, dynamic>> notes) async {
    _mockCache = notes;
  }
}