import '../database/database_service.dart';
import '../model/target_models.dart';

class TargetDao {
  final dbService = DatabaseService.db;

  /// Add new Target records
  Future<int> createTarget(TargetModel target) async {
    final db = await dbService.database;
    if (db != null) {
      /// return row added in table
      /// 0 - no row created
      var result = await db.insert('Target', target.toDatabaseJson());
      return result;
    } else {
      return 0;
    }
  }

  /// Get all Target records
  Future<List<TargetModel>> getTargets({
    List<String> columns = const [], // ["title", "deadline"]
    String? query, // 5
  }) async {
    final db = await dbService.database;

    if (db == null) return [];

    List<Map<String, dynamic>>? result;
    if (query != null) {
      if (query.isNotEmpty) {
        result = await db.query(
          'Target',
          columns: columns,
          where: 'id LIKE ?',
          whereArgs: ["%$query%"],
        );
      }
    } else {
      result = await db.query('Target', columns: columns);
    }
    // [{target json}, {target json}]
    if (result == null) return [];
    List<TargetModel> targets = result.isNotEmpty
        ? result.map((item) => TargetModel.fromDatabaseJson(item)).toList()
        : [];
    return targets;
  }

  /// Update Target records
  Future<int> updateTarget(TargetModel target) async {
    // id : 1
    // title: flutter
    // deadline: 2021-11-20
    final db = await dbService.database;

    if (db == null) return 0;

    var result = await db.update(
      'Target',
      target.toDatabaseJson(),
      where: "id = ?",
      whereArgs: [target.id],
    );

    return result;
  }

  /// Delete Target records
  Future<int> deleteTarget(int id) async {
    final db = await dbService.database;

    if (db == null) return 0;

    var result = await db.delete(
      'Target',
      where: 'id = ?',
      whereArgs: [id],
    );

    return result;
  }

  /// Delete All Target records
  Future<int> deleteAllTargets() async {
    final db = await dbService.database;

    if (db == null) return 0;

    var result = await db.delete(
      'Target',
    );

    return result;
  }
}
