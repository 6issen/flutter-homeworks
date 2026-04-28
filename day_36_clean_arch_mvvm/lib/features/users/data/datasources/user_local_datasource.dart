import '../../../../core/database/app_database.dart';
import '../models/user_model.dart';

abstract class UserLocalDataSource {
  Future<List<UserModel>> getLastUsers();
  Future<void> cacheUsers(List<UserModel> usersToCache);
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final AppDatabase database;

  UserLocalDataSourceImpl({required this.database});

  @override
  Future<List<UserModel>> getLastUsers() async {
    final result = await database.select(database.users).get();
    return result
        .map((row) => UserModel(id: row.id, name: row.name, email: row.email))
        .toList();
  }

  @override
  Future<void> cacheUsers(List<UserModel> usersToCache) async {
    await database.batch((batch) {
      batch.insertAll(
        database.users,
        usersToCache.map((user) => UsersCompanion.insert(
              id: Value(user.id),
              name: user.name,
              email: user.email,
            )),
        mode: InsertMode.insertOrReplace,
      );
    });
  }
}
