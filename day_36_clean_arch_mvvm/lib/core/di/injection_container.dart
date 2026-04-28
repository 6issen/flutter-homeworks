import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../database/app_database.dart';
import '../../features/users/data/datasources/user_local_datasource.dart';
import '../../features/users/data/datasources/user_remote_datasource.dart';
import '../../features/users/data/repositories/user_repository_impl.dart';
import '../../features/users/domain/repositories/user_repository.dart';
import '../../features/users/domain/usecases/get_users_usecase.dart';
import '../../features/users/presentation/bloc/user_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // BLoC
  sl.registerFactory(() => UserBloc(getUsersUseCase: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetUsersUseCase(sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(database: sl()),
  );

  // External
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => AppDatabase());
}
