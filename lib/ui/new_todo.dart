import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:todo_list/api/todo_api.dart' as api;

class NewTodo extends StatefulWidget {
  NewTodo({Key key}) : super(key: key);

  @override
  _NewTodoState createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  final _todoController = TextEditingController();

  void saveTodo(Todo newTodo) async {
    await api.addTodo(newTodo);
    Navigator.pop(context, newTodo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a new todo"),
      ),
      body: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: "Enter a message for your todo",
            ),
            controller: _todoController,
          ),
          RaisedButton(
            onPressed: () => saveTodo(Todo(todo: _todoController.text)),
          ),
        ],
      ),
    );
  }
}
