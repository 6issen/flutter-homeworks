abstract class NotesRemoteDataSource {
  Future<List<Map<String, dynamic>>> fetchNotes();
}

class NotesRemoteDataSourceImpl implements NotesRemoteDataSource {
  @override
  Future<List<Map<String, dynamic>>> fetchNotes() async {
    await Future.delayed(const Duration(seconds: 2)); 
    return [
      {'id': 1, 'title': 'Купить молоко', 'content': '2 пакета'},
      {'id': 2, 'title': 'Позвонить маме', 'content': 'Вечером'},
    ];
  }
}