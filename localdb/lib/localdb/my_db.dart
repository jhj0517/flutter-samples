import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/user.dart';

class MyDB {
  static const _databaseName = 'my_database.db';
  static String get databaseName => _databaseName;
  static const _databaseVersion = 1;

  // User Table
  static const userTable = 'users';
  static const userColumnId = '_id';
  static const userColumnUserId = 'user_id';
  static const userColumnUserName = 'user_name';
  static const userColumnProfileURL = 'profile_url';
  static const userColumnIsSubscribed = 'is_subscribed';

  Database? _database;
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDBPath();

    return await openDatabase(
      databasePath,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $userTable (
      $userColumnId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $userColumnUserId TEXT NOT NULL,      
      $userColumnUserName TEXT NOT NULL,            
      $userColumnProfileURL TEXT NOT NULL,
      $userColumnIsSubscribed INTEGER NOT NULL
    )
    ''');
  }

  Future<String> getDBPath() async {
    final path = await getDatabasesPath();
    return join(path, _databaseName);
  }

  Future<List<User>> getAllUsers() async {
    final db = await database;
    final result = await db.query(userTable);

    return result.map((json) => User.fromMap(json)).toList();
  }

  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert(userTable, user.toMap());
  }

  Future<void> updateUser(User user) async {
    final db = await database;
    await db.update(
      userTable,
      user.toMap(),
      where: '$userColumnId = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUser(User user) async {
    final db = await database;
    await db.delete(
      userTable,
      where: '$userColumnId = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> closeDB() async {
    final db = await database;
    await db.close();
  }

}