import '../database/database_service.dart';
import '../model/profile_model.dart';

class ProfileDao {
  final dbService = DatabaseService.db;

  Future<int> createProfile(ProfileModel p) async {
    final db = await dbService.database;
    if (db != null) {
      var result = await db.insert('Profile', p.toDatabaseJson());
      return result;
    } else {
      return 0;
    }
  }

  Future<ProfileModel?> getProfile() async {
    final db = await dbService.database;

    if (db == null) return null;

    List<Map<String, dynamic>>? result;
    result = await db.query('Profile', limit: 1);

    if (result.isEmpty) return null;
    ProfileModel p = ProfileModel.fromDatabaseJson(result.first);
    return p;
  }

  /// Update Target records
  Future<int> updateProfile(ProfileModel p) async {
    final db = await dbService.database;

    if (db == null) return 0;

    var result = await db.update(
      'Profile',
      p.toDatabaseJson(),
      where: "id = ?",
      whereArgs: [p.id],
    );

    return result;
  }

  Future<int> deleteProfile(int id) async {
    final db = await dbService.database;

    if (db == null) return 0;

    var result = await db.delete(
      'Profile',
      where: 'id = ?',
      whereArgs: [id],
    );

    return result;
  }
}
