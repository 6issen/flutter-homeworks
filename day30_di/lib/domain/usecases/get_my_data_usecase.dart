import '../../data/repository/my_repository.dart';

class GetMyDataUseCase {
  final MyRepository repository;

  GetMyDataUseCase({required this.repository});

  Future<String> call() => repository.getData();
}