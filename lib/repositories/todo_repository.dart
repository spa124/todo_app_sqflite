import '../models/todo_item.dart';
import '../services/db_helper.dart';

class TodoRepository {
  final DBHelper _dbHelper = DBHelper();

  Future<List<TodoItem>> fetchTodoItems() async {
    return await _dbHelper.fetchTodoItems();
  }

  Future<int> insertTodoItem(TodoItem item) async {
    return await _dbHelper.insertTodoItem(item);
  }

  Future<int> updateTodoItem(TodoItem item) async {
    return await _dbHelper.updateTodoItem(item);
  }

  Future<int> deleteTodoItem(int id) async {
    return await _dbHelper.deleteTodoItem(id);
  }
}
