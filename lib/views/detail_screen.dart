import 'package:flutter/material.dart';
import '../models/todo_item.dart';
import 'add_edit_screen.dart';

class DetailScreen extends StatelessWidget {
  final TodoItem item;

  DetailScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do Details'),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Section
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade50,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8.0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                  SizedBox(height: 8),
                  Text(item.title, style: TextStyle(fontSize: 18, color: Colors.black87)),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Description Section
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade50,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8.0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Description', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                  SizedBox(height: 8),
                  Text(item.description, style: TextStyle(fontSize: 18, color: Colors.black87)),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Status Section
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade50,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8.0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Status', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                  SizedBox(height: 8),
                  Text(
                    item.isCompleted ? 'Completed' : 'Not Completed',
                    style: TextStyle(fontSize: 18, color: item.isCompleted ? Colors.green : Colors.redAccent),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: item.isCompleted
          ? null
          : FloatingActionButton(
              child: Icon(Icons.edit, color: Colors.white),
              backgroundColor: Colors.redAccent,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddEditScreen(todoItem: item),
                  ),
                );
              },
            ),
    );
  }
}
