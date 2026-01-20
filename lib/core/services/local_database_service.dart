import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_list/core/services/request_limiter_service.dart';

class LocalDatabaseService {
  static Database? _database;

  Future<Database> get _getDatabase async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<void> get _close async {
    final db = await _getDatabase;
    await db.close();
    _database = null;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'todo_list.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE tasks (
            id TEXT PRIMARY KEY,
            json_data TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> save({required String table, required String id, required String jsonData, required String action}) async {
    RequestLimiterService.instance.verify(action: action);

    final db = await _getDatabase;
    await db.insert(table, {'id': id, 'json_data': jsonData}, conflictAlgorithm: ConflictAlgorithm.replace);
    await _close;
  }

  Future<void> delete({required String table, required String id, required String action}) async {
    RequestLimiterService.instance.verify(action: action);

    final db = await _getDatabase;
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
    await _close;
  }

  Future<List<Map<String, dynamic>>> getAll({required String table, required String action}) async {
    RequestLimiterService.instance.verify(action: action);

    final db = await _getDatabase;
    final List<Map<String, Object?>> results = await db.query(table);
    await _close;

    return results.map((row) {
      if (row['json_data'] != null) {
        return jsonDecode(row['json_data'] as String) as Map<String, dynamic>;
      }
      return <String, dynamic>{};
    }).toList();
  }
}
