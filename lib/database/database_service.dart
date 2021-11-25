import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService db = DatabaseService();

  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "Todo.db");
    var database = await openDatabase(
      path,
      version: 2,
      onCreate: initDB,
      onUpgrade: onUpgrade,
    );
    return database;
  }

  Future<void> onUpgrade(
    Database database,
    int oldVersion,
    int newVersion,
  ) async {
    if (newVersion == 2) {
      await database.execute(
        "CREATE TABLE Profile ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "name TEXT, "
        "image TEXT "
        ")",
      );
      log('Profile Table created.');
      await database.execute(
        "CREATE TABLE Task ("
        "id INTEGER PRIMARY KEY AUTOINCREMENT, "
        "targetId INTEGER, "
        "title TEXT, "
        "start TEXT, "
        "finish TEXT, "
        "isFinished INTEGER "
        ")",
      );
      log('Profile Task created.');
    }
  }

  void initDB(Database database, int version) async {
    await database.execute(
      "CREATE TABLE Target ("
      "id INTEGER PRIMARY KEY AUTOINCREMENT, "
      "title TEXT, "
      "deadline TEXT "
      ")",
    );
  }
}
