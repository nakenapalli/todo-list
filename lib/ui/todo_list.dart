import 'package:flutter/material.dart';
import 'package:todo_list/api/todo_api.dart' as api;
import 'package:todo_list/models/todo_model.dart';
import 'dart:convert';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TodoList extends StatefulWidget {
  TodoList({Key key}) : super(key: key);

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Todo> todoList = [];
  bool completed = false;

  _getTodos() async {
    await api.fetchTodoList().then((response) => setState(() {
          var data = json.decode(response.body);
          Iterable list = data as List;
          // todoList = list.map((model) => Todo.fromJson(model)).toList();
          todoList.clear();

          list.forEach((element) {
            try {
              todoList.add(Todo.fromJson(element));
            } catch (e) {
              print("Error value on element $element");
            }
          });
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

  Widget buildTodoItem(int index, List<Todo> todos) {
    return Card(
      margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      elevation: 3,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.indigoAccent),
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListTile(
        leading: Padding(
          padding: EdgeInsets.only(top: 12, left: 5),
          child: Text(
            todos[index].id.toString(),
            style: TextStyle(
              color: Colors.indigoAccent,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        title: Text(todos[index].todo),
        subtitle: isCompleted(todos[index].completed),
        trailing: IconButton(
          icon: Icon(
            MdiIcons.checkBold,
            color: Colors.indigoAccent,
          ),
          onPressed: () => setState(() {
            api.markTodo(todos[index]);
          }),
        ),
      ),
    );
  }

  List<Widget> createTodoList() {
    List<Todo> currentList;

    if (completed) {
      currentList = todoList.where((todo) => todo.completed).toList();
    } else {
      currentList = todoList.where((todo) => !(todo.completed)).toList();
    }

    return List.generate(
        currentList.length, (index) => buildTodoItem(index, currentList));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(MdiIcons.clipboardListOutline, color: Colors.white),
        title: Text("Todo List"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              completed ? MdiIcons.checkboxMarked : MdiIcons.checkBoxOutline,
              color: Colors.white,
              size: 40,
            ),
            onPressed: () => {
              setState(() {
                completed = !completed;
              })
            },
            splashColor: Colors.indigo[300],
          ),
          SizedBox(width: 10),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(5),
        children: createTodoList(),
      ),
    );
  }
}
