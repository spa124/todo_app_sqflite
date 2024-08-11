import 'package:flutter/material.dart';
import '../models/todo_item.dart';
import '../repositories/todo_repository.dart';

class TodoViewModel with ChangeNotifier {
  List<TodoItem> _todoItems = [];
  final TodoRepository _todoRepository = TodoRepository();

  List<TodoItem> get todoItems => _todoItems;

  Future<void> loadTodoItems() async {
    _todoItems = await _todoRepository.fetchTodoItems();
    notifyListeners();
  }

  Future<void> addTodoItem(TodoItem item) async {
    await _todoRepository.insertTodoItem(item);
    await loadTodoItems();
  }

  Future<void> updateTodoItem(TodoItem item) async {
    await _todoRepository.updateTodoItem(item);
    await loadTodoItems();
  }

  Future<void> deleteTodoItem(int id) async {
    await _todoRepository.deleteTodoItem(id);
    await loadTodoItems();
  }
}
