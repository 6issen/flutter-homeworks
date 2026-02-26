import '../api/api_client.dart';

class MyRepository {
  final ApiClient apiClient;

  MyRepository({required this.apiClient});

  Future<String> getData() => apiClient.fetchData();
}