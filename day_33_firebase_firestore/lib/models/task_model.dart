import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  final String id;
  final String uid;
  final String title;
  final String status; // 'active' или 'completed'
  final String category;
  final List<String> searchKeywords; // Массив для поиска
  final DateTime createdAt;

  TaskModel({
    required this.id,
    required this.uid,
    required this.title,
    required this.status,
    required this.category,
    required this.searchKeywords,
    required this.createdAt,
  });

  // Из Firestore в Dart
  factory TaskModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TaskModel(
      id: doc.id,
      uid: data['uid'] ?? '',
      title: data['title'] ?? '',
      status: data['status'] ?? 'active',
      category: data['category'] ?? 'general',
      searchKeywords: List<String>.from(data['searchKeywords'] ?? []),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  // Из Dart в Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'title': title,
      'status': status,
      'category': category,
      'searchKeywords': searchKeywords,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}