import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class ApiClient {
  Future<List<Map<String, dynamic>>> getNotes();
  Future<void> addNote(String title);
  Future<bool> login(String username, String password);
}

class ApiClientImpl implements ApiClient {
  final String baseUrl = 'https://api.example.com';
  final http.Client client;

  ApiClientImpl(this.client);

  @override
  Future<List<Map<String, dynamic>>> getNotes() async {
    final response = await client.get(Uri.parse('$baseUrl/notes'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    }
    throw Exception('Failed to load notes');
  }

  @override
  Future<void> addNote(String title) async {
    final response = await client.post(
      Uri.parse('$baseUrl/notes'),
      body: json.encode({'title': title}),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add note');
    }
  }

  @override
  Future<bool> login(String username, String password) async {
    // Simulated login
    if (username == 'admin' && password == '1234') return true;
    return false;
  }
}
