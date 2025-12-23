class PostsModel {
  const PostsModel({
    required this.id,
    required this.title,
    required this.body,
  });

  factory PostsModel.fromJson(Map<String, dynamic> json) {
    return PostsModel(
      id: json['id'] as int, 
      title: json['title'] as String,
      body: json['body']as String,
    );
  }

  final int id;
  final String title;
  final String body;
}