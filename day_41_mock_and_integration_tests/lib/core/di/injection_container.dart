import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import '../../data/repositories/notes_repository.dart';
import '../../data/services/api_client.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Services
  sl.registerLazySingleton<http.Client>(() => http.Client());
  sl.registerLazySingleton<ApiClient>(() => ApiClientImpl(sl()));

  // Repositories
  sl.registerLazySingleton<NotesRepository>(() => NotesRepository(sl()));
}
