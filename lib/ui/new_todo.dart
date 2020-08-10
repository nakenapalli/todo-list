import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:todo_list/api/todo_api.dart' as api;
import 'package:google_fonts/google_fonts.dart';

class NewTodo extends StatefulWidget {
  NewTodo({Key key}) : super(key: key);

  @override
  _NewTodoState createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  final _todoController = TextEditingController();

  void saveTodo(Todo newTodo) async {
    await api.addTodo(newTodo);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create a new todo",
          style: GoogleFonts.poppins(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              style: GoogleFonts.poppins(color: Colors.indigo),
              decoration: InputDecoration(
                labelText: "Enter a message for your todo",
                labelStyle: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.indigo,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo),
                  borderRadius: BorderRadius.circular(25),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.indigo),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              controller: _todoController,
            ),
            SizedBox(height: 25),
            RaisedButton(
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30),
              color: Colors.indigo,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                "Save",
                style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
              ),
              onPressed: () => saveTodo(Todo(todo: _todoController.text)),
            ),
          ],
        ),
      ),
    );
  }
}
