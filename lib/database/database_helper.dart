import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:uas_mobile/models/user_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY, fullname TEXT, email TEXT, password TEXT)",
        );
      },
    );
  }

  Future<void> insertUser(UserModel user) async {
    final db = await database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<UserModel?> getUser(String email, String password) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: "email = ? AND password = ?",
      whereArgs: [email, password],
    );
    if (maps.isNotEmpty) {
      return UserModel.fromMap(maps.first);
    } else {
      return null;
    }
  }
}
