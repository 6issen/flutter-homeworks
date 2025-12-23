import 'dart:convert';

import 'package:hw7/data/posts_model.dart';
import 'package:http/http.dart' as http;

class ListController {
  static Future<List<PostsModel>> fetchPosts() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts')
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => PostsModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed request ${response.statusCode}');
    }
  }
}