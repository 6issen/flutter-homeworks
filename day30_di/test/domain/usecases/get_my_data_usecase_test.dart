import 'package:day30_di/data/api/api_client.dart';
import 'package:day30_di/data/repository/my_repository.dart';
import 'package:day30_di/domain/usecases/get_my_data_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

class TestMockApiClient implements ApiClient {
  @override
  Future<String> fetchData() async {
    return 'Данные из Unit-теста';
  }
}

void main() {
  final locator = GetIt.instance;

  setUp(() {
    locator.reset();

    locator.registerSingleton<ApiClient>(TestMockApiClient());
    locator.registerLazySingleton<MyRepository>(
      () => MyRepository(apiClient: locator<ApiClient>()),
    );
    locator.registerFactory<GetMyDataUseCase>(
      () => GetMyDataUseCase(repository: locator<MyRepository>()),
    );
  });

  test('UseCase должен возвращать данные из подмененного ApiClient', () async {
    final useCase = locator<GetMyDataUseCase>();
    final result = await useCase.call();
    expect(result, 'Данные из Unit-теста');
  });
}