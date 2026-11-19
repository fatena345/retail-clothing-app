
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteService extends GetxService {
  Database? _database;

  Future<Database> init() async {
    if (_database != null) return _database!;

    final databasesPath = await getDatabasesPath();
    final dbPath = join(databasesPath, 'geeta.db');

    _database = await openDatabase(
      dbPath,
      version: 1,
   
onCreate: (db, version) async {
  await db.execute('''
    CREATE TABLE register_drafts (
      id INTEGER PRIMARY KEY,
      email TEXT,
      name TEXT,
      commercialName TEXT,
      commercialAccount TEXT,
      storeLicensePath TEXT
    )
  ''');
},
    );

    return _database!;
  }

  Future<int> insertData(
    {required String tableName,
   required Map<String, dynamic> values,}
  ) async {
    final db = await init();
    return await db.insert(tableName, values);
  }

  Future<List<Map<String, Object?>>> getData({
    required String tableName,
    String? where,
    List<Object?>? whereArgs,
  }) async {
    final db = await init();

    return await db.query(
      tableName,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<int> updateData({
    required String tableName,
    required Map<String, dynamic> values,
    required String where,
    required List<Object?> whereArgs,
  }) async {
    final db = await init();

    return await db.update(
      tableName,
      values,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<int> deleteData({
    required String tableName,
    required String where,
    required List<Object?> whereArgs,
  }) async {
    final db = await init();

    return await db.delete(
      tableName,
      where: where,
      whereArgs: whereArgs,
    );
  }
}
