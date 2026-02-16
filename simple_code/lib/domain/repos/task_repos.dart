import 'package:simple_code/domain/entity/task_entity.dart';

abstract interface class TaskRepos {
  Future<TaskEntity> getInfo();
}

class TaskReposImpl implements TaskRepos {
  const TaskReposImpl();
  
  @override
  Future<TaskEntity> getInfo() async {
    await Future.delayed(const Duration(seconds: 3));

    return TaskEntity(
      title: "Title 1",
      description: "Description 1"
    );
  }
  
}

class TaskReposImplFake implements TaskRepos {
  const TaskReposImplFake();
  
  @override
  Future<TaskEntity> getInfo() async {
    await Future.delayed(const Duration(seconds: 3));

    return TaskEntity(
      title: "Title Fake",
      description: "Description Fake"
    );
  }
  
}