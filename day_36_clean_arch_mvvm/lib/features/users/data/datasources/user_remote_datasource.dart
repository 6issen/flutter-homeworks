import 'package:dio/dio.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<UserModel>> getUsers() async {
    final response = await dio.get('https://jsonplaceholder.typicode.com/users');
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((user) => UserModel.fromJson(user))
          .toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}
