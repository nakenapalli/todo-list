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

  Widget buildTodoItem(int index) {
    return ListTile(
      leading: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Text(todoList[index].id.toString()),
      ),
      title: Text(todoList[index].todo),
      subtitle: isCompleted(todoList[index].completed),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(MdiIcons.clipboardListOutline, color: Colors.white),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("Todo List"),
            FlatButton(
                padding: EdgeInsets.only(left: 50),
                onPressed: () => {
                      setState(() {
                        completed = !completed;
                      })
                    },
                child: completed
                    ? Icon(
                        MdiIcons.checkboxMarked,
                        color: Colors.white,
                      )
                    : Icon(
                        MdiIcons.checkBoxOutline,
                        color: Colors.white,
                      )),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          if (completed) {
            if (todoList[index].completed) {
              return buildTodoItem(index);
            } else {
              return null;
            }
          } else {
            if (todoList[index].completed) {
              return null;
            } else {
              return buildTodoItem(index);
            }
          }
        },
      ),
    );
  }
}
