import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo_item.dart';
import '../viewmodels/todo_view_model.dart';
import 'add_edit_screen.dart';
import 'detail_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todoViewModel = Provider.of<TodoViewModel>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Todo List',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.redAccent,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(Icons.add, size: 32),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddEditScreen(),
                  ));
                },
              ),
            ),
          ],
        ),
        body: FutureBuilder(
          future: todoViewModel.loadTodoItems(),
          builder: (ctx, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('An error occurred!'));
            } else {
              return ListView.builder(
                itemCount: todoViewModel.todoItems.length,
                itemBuilder: (ctx, i) {
                  final item = todoViewModel.todoItems[i];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.blueGrey.shade50, // Card background color
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      title: Text(
                        item.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          item.description,
                          style: TextStyle(fontSize: 14, color: const Color.fromARGB(255, 8, 151, 207)),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: item.isCompleted,
                            onChanged: (value) {
                              todoViewModel.updateTodoItem(
                                TodoItem(
                                  id: item.id,
                                  title: item.title,
                                  description: item.description,
                                  isCompleted: value!,
                                ),
                              );
                            },
                            activeColor: item.isCompleted ? Colors.green : Colors.red,
                          ),
                          IconButton(
                            icon: Icon(Icons.edit, color: const Color.fromARGB(255, 162, 123, 123)),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AddEditScreen(todoItem: item),
                              ));
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: Text('Confirm Deletion'),
                                  content: Text('Are you sure you want to delete this item?'),
                                  actions: [
                                    TextButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(ctx).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Delete'),
                                      onPressed: () async {
                                        await todoViewModel.deleteTodoItem(item.id!);
                                        Navigator.of(ctx).pop();
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailScreen(item: item),
                        ));
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
