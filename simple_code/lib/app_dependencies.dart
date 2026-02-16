import 'package:get_it/get_it.dart';
import 'package:simple_code/domain/repos/task_repos.dart';

class AppDependencies {
  AppDependencies._();

  static final instance = GetIt.I;

  static void setupDependencies() {
    instance.registerLazySingleton<TaskRepos>(
      () => TaskReposImpl(),
      instanceName: 'prod'
    );
  }

  static void fakeDependencies() {
    instance.registerLazySingleton<TaskRepos>(
      () => TaskReposImplFake(),
      instanceName: 'fake'
    );
  }

}