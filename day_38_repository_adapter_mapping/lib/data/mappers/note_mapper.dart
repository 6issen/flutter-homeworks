import '../../domain/entities/note.dart';

class NoteMapper {
  static Note fromJson(Map<String, dynamic> json) {
    
    if (json['id'] == null) {
      throw const FormatException('Некорректные данные: отсутствует ID');
    }

    return Note(
      id: json['id'] as int,
      title: json['title'] as String? ?? 'Без названия',
      content: json['content'] as String? ?? '',
    );
  }

  static Map<String, dynamic> toJson(Note note) {
    return {
      'id': note.id,
      'title': note.title,
      'content': note.content,
    };
  }
}