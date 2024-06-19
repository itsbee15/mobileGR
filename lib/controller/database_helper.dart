import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _database;

  DatabaseHelper._instance();

  String tableName = 'scan_results';
  String colId = 'id';
  String colQrTag = 'qr_tag';
  String colMaterialCode = 'material_code';
  String colQuantity = 'quantity';
  String colQuantityNg = 'quantity_ng';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'scan_results.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        $colId INTEGER PRIMARY KEY AUTOINCREMENT,
        $colQrTag TEXT,
        $colMaterialCode TEXT,
        $colQuantity INTEGER,
        $colQuantityNg INTEGER
      )
    ''');
  }

  Future<int> insertScanResult(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> getAllScanResults() async {
    Database db = await instance.database;
    return await db.query(tableName);
  }

  Future<int> deleteScanResult(int id) async {
    Database db = await instance.database;
    return await db.delete(tableName, where: '$colId = ?', whereArgs: [id]);
  }
}
