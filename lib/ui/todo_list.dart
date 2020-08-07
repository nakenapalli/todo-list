import 'package:flutter/material.dart';
import 'package:todo_list/api/todo_api.dart' as api;
import 'package:todo_list/models/todo_model.dart';
import 'dart:convert';

class TodoList extends StatefulWidget {
  TodoList({Key key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Todo> todoList;

  _getTodos() async {
    await api.fetchTodoList().then((response) => setState(() {
          var data = json.decode(response.body);
          //Iterable list = data as List;
          todoList = data.map((model) => Todo.fromJson(model)).toList();
        }));
  }

  @override
  void initState() {
    _getTodos();
    super.initState();
  }

  Widget isCompleted(bool completed) {
    if (completed) {
      return Text("complete");
    } else {
      return Text("incomplete");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) => ListTile(
          leading: Text(todoList[index].id.toString()),
          title: Text(todoList[index].todo),
          subtitle: isCompleted(todoList[index].completed),
          onTap: () {},
        ),
      ),
    );
  }
}
