import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDbService {
  Database? _db;

  Future<void> initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "runs.db");

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute("""
          CREATE TABLE runs(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            distance REAL,
            duration REAL,
            date TEXT
          )
        """);
      },
    );
  }

  Future<int> insertRun(Map<String, dynamic> run) async {
    return await _db!.insert("runs", run,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getRuns() async {
    return await _db!.query("runs");
  }
}
