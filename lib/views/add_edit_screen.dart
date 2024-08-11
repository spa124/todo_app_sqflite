import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/viewmodels/todo_view_model.dart';
import 'package:todo_app/views/home_screen.dart';
import '../models/todo_item.dart';

class AddEditScreen extends StatefulWidget {
  final TodoItem? todoItem;

  AddEditScreen({this.todoItem});

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _title;
  String? _description;
  bool _isCompleted = false;

  @override
  void initState() {
    if (widget.todoItem != null) {
      _title = widget.todoItem!.title;
      _description = widget.todoItem!.description;
      _isCompleted = widget.todoItem!.isCompleted;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.todoItem == null ? 'Add To-Do' : 'Edit To-Do',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.redAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.todoItem == null ? 'Add Task' : 'Edit Task',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  initialValue: _title,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16.0,
                    ),
                    hintText: 'Enter your title here',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _title = value ?? '';
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  initialValue: _description,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16.0,
                    ),
                    hintText: 'Enter a detailed description here',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                  ),
                  onSaved: (value) {
                    _description = value ?? '';
                  },
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                ),
                SizedBox(height: 16),
                CheckboxListTile(
                  title: Text(
                    'Completed',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  value: _isCompleted,
                  onChanged: (value) {
                    setState(() {
                      _isCompleted = value!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Colors.green, // Set active color to green
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent, // Background color
                      foregroundColor: Colors.white, // Font color
                      padding: EdgeInsets.symmetric(horizontal: 30.0 ), // Padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0), // Rounded corners
                      ),
                    ),
                    child: Text(
                      widget.todoItem == null ? 'Add' : 'Save',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (widget.todoItem == null) {
                          todoProvider.addTodoItem(
                            TodoItem(
                              title: _title!,
                              description: _description!,
                              isCompleted: _isCompleted,
                            ),
                          );
                        } else {
                          todoProvider.updateTodoItem(
                            TodoItem(
                              id: widget.todoItem!.id,
                              title: _title!,
                              description: _description!,
                              isCompleted: _isCompleted,
                            ),
                          );
                        }
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
