import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/todo_item.dart';

class DBHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'todo_list.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  void _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE todos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        isCompleted INTEGER
      )
    ''');
  }

  Future<int> insertTodoItem(TodoItem item) async {
    final db = await database;
    return await db.insert('todos', item.toMap());
  }

  Future<List<TodoItem>> fetchTodoItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('todos');
    return List.generate(maps.length, (i) {
      return TodoItem.fromMap(maps[i]);
    });
  }

  Future<int> updateTodoItem(TodoItem item) async {
    final db = await database;
    return await db.update('todos', item.toMap(), where: 'id = ?', whereArgs: [item.id]);
  }

  Future<int> deleteTodoItem(int id) async {
    final db = await database;
    return await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}
