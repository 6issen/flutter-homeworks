class TaskEntity {

  const TaskEntity({
    required this.title,
    required this.description,
    required this.createdDate,
  });

  final String title;
  final String description;
  final DateTime createdDate;
}