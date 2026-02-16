import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'local_database.g.dart';

class TaskTags extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 20)();
  IntColumn get color => integer().nullable()();
}

class TaskItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 50)();
  DateTimeColumn get dueDate => dateTime().nullable()();
  IntColumn get priority => integer().withDefault(const Constant(0))(); 
  IntColumn get tagId => integer().nullable().references(TaskTags, #id)();
}

class TaskWithTag {
  final TaskItem task;
  final TaskTag? tag;

  TaskWithTag(this.task, this.tag);
}

@DriftDatabase(tables: [TaskItems, TaskTags])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> addTask(TaskItemsCompanion entry) {
    return into(taskItems).insert(entry);
  }
  
  Future<int> addTag(TaskTagsCompanion entry) {
    return into(taskTags).insert(entry);
  }

  Future<bool> updateTask(TaskItem entry) {
    return update(taskItems).replace(entry);
  }

  Future<int> deleteTask(TaskItem entry) {
    return delete(taskItems).delete(entry);
  }

  SimpleSelectStatement<$TaskItemsTable, TaskItem> _buildQuery(bool sortByPriority) {
    var query = select(taskItems);
    if (sortByPriority) {
      query.orderBy([
        (t) => OrderingTerm(expression: t.priority, mode: OrderingMode.desc),
        (t) => OrderingTerm(expression: t.dueDate),
      ]);
    } else {
      query.orderBy([(t) => OrderingTerm(expression: t.dueDate)]);
    }
    return query;
  }

  Stream<List<TaskWithTag>> watchAllTasks({bool sortByPriority = false}) {
    final query = _buildQuery(sortByPriority).join([
      leftOuterJoin(taskTags, taskTags.id.equalsExp(taskItems.tagId)),
    ]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return TaskWithTag(
          row.readTable(taskItems),
          row.readTableOrNull(taskTags),
        );
      }).toList();
    });
  }

  Future<List<TaskWithTag>> getAllTasks({bool sortByPriority = false}) async {
    final query = _buildQuery(sortByPriority).join([
      leftOuterJoin(taskTags, taskTags.id.equalsExp(taskItems.tagId)),
    ]);

    final rows = await query.get();
    
    return rows.map((row) {
      return TaskWithTag(
        row.readTable(taskItems),
        row.readTableOrNull(taskTags),
      );
    }).toList();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'tasks_db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}