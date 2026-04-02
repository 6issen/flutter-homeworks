import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String collectionPath = 'tasks';

  // Генерация ключевых слов для поиска (разбиваем строку на слова)
  List<String> _generateSearchKeywords(String text) {
    return text.toLowerCase().split(' ').where((word) => word.isNotEmpty).toList();
  }

  // 1. CREATE
  Future<void> addTask({
    required String uid,
    required String title,
    required String category
  }) async {
    final docRef = _db.collection(collectionPath).doc(); // Генерируем ID
    final task = TaskModel(
      id: docRef.id,
      uid: uid,
      title: title,
      status: 'active',
      category: category,
      searchKeywords: _generateSearchKeywords(title),
      createdAt: DateTime.now(),
    );
    await docRef.set(task.toMap());
  }

  // 2. READ (Real-time с фильтрами, поиском и лимитом для пагинации)
  Stream<List<TaskModel>> getTasksStream({
    required String uid,
    required int limit,
    String? categoryFilter,
    String? searchQuery,
  }) {
    // Базовый запрос: только свои задачи
    Query query = _db.collection(collectionPath).where('uid', isEqualTo: uid);

    // Фильтр по категории
    if (categoryFilter != null && categoryFilter.isNotEmpty) {
      query = query.where('category', isEqualTo: categoryFilter);
    }

    // Поиск по ключевым словам
    if (searchQuery != null && searchQuery.isNotEmpty) {
      query = query.where('searchKeywords', arrayContains: searchQuery.toLowerCase());
    }

    // Сортировка по дате и пагинация (увеличение лимита)
    query = query.orderBy('createdAt', descending: true).limit(limit);

    // Возвращаем поток (stream)
    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => TaskModel.fromDocument(doc)).toList();
    });
  }

  // 3. UPDATE
  Future<void> updateTaskStatus(String id, String newStatus) async {
    await _db.collection(collectionPath).doc(id).update({'status': newStatus});
  }

  // 4. DELETE
  Future<void> deleteTask(String id) async {
    await _db.collection(collectionPath).doc(id).delete();
  }
}