import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_local_datasource.dart';
import '../datasources/user_remote_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<UserEntity>> getUsers() async {
    try {
      final remoteUsers = await remoteDataSource.getUsers();
      await localDataSource.cacheUsers(remoteUsers);
      return remoteUsers;
    } catch (e) {
      final localUsers = await localDataSource.getLastUsers();
      if (localUsers.isNotEmpty) {
        return localUsers;
      }
      rethrow;
    }
  }
}
