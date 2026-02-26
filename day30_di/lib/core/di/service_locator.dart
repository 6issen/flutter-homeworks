import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/api/api_client.dart';
import '../../data/repository/my_repository.dart';
import '../../domain/usecases/get_my_data_usecase.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  // Асинхронная инициализация
  final prefs = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferences>(prefs);

  // Переключение по флагу
  if (kReleaseMode) {
    locator.registerLazySingleton<ApiClient>(() => RealApiClient());
  } else {
    locator.registerLazySingleton<ApiClient>(() => MockApiClient());
  }

  // Регистрация Repository
  locator.registerLazySingleton<MyRepository>(
    () => MyRepository(apiClient: locator<ApiClient>()),
  );

  // Регистрация UseCase
  locator.registerFactory<GetMyDataUseCase>(
    () => GetMyDataUseCase(repository: locator<MyRepository>()),
  );
}