import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteDatabase {
  static const _databaseName = 'database.db';
  static const _databaseVersion = 1;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE guests (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        gender TEXT NOT NULL,
        name TEXT NOT NULL,
        address TEXT NOT NULL,
        email TEXT NOT NULL,
        profile TEXT NOT NULL,
        dob TEXT NOT NULL,
        registry TEXT NOT NULL,
        phone TEXT NOT NULL,
        cell TEXT NOT NULL,
        id_model TEXT NOT NULL,
        picture TEXT NOT NULL,
        nat TEXT NOT NULL
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE guests ADD COLUMN age INTEGER');
    }
  }

  Future<void> clearDatabase() async {
    final db = await database;
    await db.delete('guests');
  }

  static Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);
    await deleteDatabase(path);
  }
}
