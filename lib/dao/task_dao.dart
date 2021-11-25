import '../database/database_service.dart';
import '../model/task_model.dart';

class TaskDao {
  final dbService = DatabaseService.db;

  /// Add new Task records
  Future<int> createTask(TaskModel task) async {
    final db = await dbService.database;
    if (db != null) {
      /// return row added in table
      /// 0 - no row created
      var result = await db.insert('Task', task.toDatabaseJson());
      return result;
    } else {
      return 0;
    }
  }

  /// Get all Tasks records
  Future<List<TaskModel>> getTasks({
    List<String> columns = const [],
    String? queryKey, // targetId
    String? queryParameter, // 1
  }) async {
    final db = await dbService.database;

    if (db == null) return [];

    List<Map<String, dynamic>>? result;
    if (queryKey != null || queryParameter != null) {
      result = await db.query(
        'Task',
        columns: columns,
        where: '$queryKey LIKE ?', // targetId LIKE %1%
        whereArgs: ["%$queryParameter%"], // flutter => flu
      );
    } else {
      result = await db.query('Task', columns: columns);
    }

    List<TaskModel> tasks = result.isNotEmpty
        ? result.map((item) => TaskModel.fromDatabaseJson(item)).toList()
        : [];
    return tasks;
  }

  /// Update Task records
  Future<int> updateTasks(TaskModel task) async {
    final db = await dbService.database;

    if (db == null) return 0;

    var result = await db.update(
      'Task',
      task.toDatabaseJson(),
      where: "id = ?",
      whereArgs: [task.id],
    );

    return result;
  }

  /// Delete Task records
  Future<int> deleteTask(int id) async {
    final db = await dbService.database;

    if (db == null) return 0;

    var result = await db.delete(
      'Task',
      where: 'id = ?',
      whereArgs: [id],
    );

    return result;
  }

  /// Delete All Tasks records
  Future<int> deleteAllTasks() async {
    final db = await dbService.database;

    if (db == null) return 0;

    var result = await db.delete(
      'Task',
    );

    return result;
  }
}
