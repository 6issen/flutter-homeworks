abstract class ApiClient {
  Future<String> fetchData();
}

class RealApiClient implements ApiClient {
  @override
  Future<String> fetchData() async {
    await Future.delayed(const Duration(seconds: 2));
    return 'Данные из реального API';
  }
}

class MockApiClient implements ApiClient {
  @override
  Future<String> fetchData() async {
    return 'Тестовые данные (Mock)';
  }
}