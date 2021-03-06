import 'package:flutter/material.dart';
import 'package:todo_list/api/todo_api.dart' as api;
import 'package:todo_list/models/todo_model.dart';
import 'dart:convert';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

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
      return Text(
        "Complete",
        style: GoogleFonts.poppins(fontSize: 10),
      );
    } else {
      return Text(
        "Incomplete",
        style: GoogleFonts.poppins(fontSize: 10),
      );
    }
  }

  void markTodo(Todo todo) async {
    await api.markTodo(todo).then((updated) => setState(() {
          int index = todoList.indexOf(todo);
          todoList.replaceRange(index, index + 1, [updated]);
        }));
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
        contentPadding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        leading: Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Text(
            todos[index].id.toString(),
            style: GoogleFonts.poppins(
              color: Colors.indigoAccent,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        title: Text(
          todos[index].todo,
          style: GoogleFonts.poppins(fontSize: 13, height: 1.2),
        ),
        subtitle: isCompleted(todos[index].completed),
        trailing: Container(
          // decoration: BoxDecoration(
          //   border: Border.all(color: Colors.black, width: 1),
          // ),
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  completed
                      ? Text(
                          "Undo",
                          style: GoogleFonts.poppins(fontSize: 8),
                          overflow: TextOverflow.visible,
                        )
                      : Text(
                          "Mark done",
                          style: GoogleFonts.poppins(fontSize: 8),
                          overflow: TextOverflow.visible,
                        ),
                  SizedBox(
                    height: 30,
                    child: FlatButton(
                      child: Icon(
                        completed
                            ? MdiIcons.checkboxMarkedCircleOutline
                            : MdiIcons.checkboxBlankCircleOutline,
                        color: Colors.indigoAccent,
                        size: 25,
                      ),
                      splashColor: Colors.indigoAccent[700],
                      onPressed: () => markTodo(todos[index]),
                    ),
                  ),
                ],
              ),
              /**
               * Not sure how to include this second button in the container
               * without causing overflow
               * Want to keep the Row items close together
               */
              // Column(
              //   children: <Widget>[
              //     Text(
              //       "Delete",
              //       style: GoogleFonts.poppins(fontSize: 8),
              //       overflow: TextOverflow.visible,
              //     ),
              //     SizedBox(
              //       height: 30,
              //       child: FlatButton(
              //         child: Icon(
              //           MdiIcons.delete,
              //           color: Colors.indigoAccent,
              //           size: 25,
              //         ),
              //         splashColor: Colors.indigoAccent[700],
              //         onPressed: () {},
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
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
      currentList.length,
      (index) => buildTodoItem(index, currentList),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget yesButton = FlatButton(
      child: Text("YES"),
      onPressed: () => Navigator.pushNamed(context, '/'),
    );
    Widget noButton = FlatButton(
      child: Text("NO"),
      onPressed: () => Navigator.pop(context),
    );

    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Are you sure you want to log out?"),
      actions: [
        yesButton,
        noButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(MdiIcons.formatListChecks, color: Colors.white),
        title: Text(
          "Todo List",
          style: GoogleFonts.poppins(fontSize: 30),
        ),
        actions: <Widget>[
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Text("View", style: GoogleFonts.poppins(fontSize: 8)),
          //     SizedBox(
          //       width: 80,
          //       height: 30,
          //       child:
          IconButton(
            icon: Icon(
              completed ? MdiIcons.checkboxMarked : MdiIcons.checkBoxOutline,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () => {
              setState(() {
                completed = !completed;
              })
            },
            splashColor: Colors.indigo[300],
          ),
          //     ),
          //   ],
          // ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Text("Add", style: GoogleFonts.poppins(fontSize: 8)),
          //     SizedBox(
          //       width: 80,
          //       height: 30,
          //       child:
          IconButton(
            icon: Icon(
              MdiIcons.plusBoxOutline,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () => Navigator.pushNamed(
              context,
              '/new',
            ).then((value) => setState(() {
                  _getTodos();
                })),
            splashColor: Colors.indigo[300],
          ),
          //     ),
          //   ],
          // ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          //     Text("Logout", style: GoogleFonts.poppins(fontSize: 8)),
          //     SizedBox(
          //       width: 80,
          //       height: 30,
          //       child:
          IconButton(
            icon: Icon(
              MdiIcons.logoutVariant,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () => showAlertDialog(context),
            splashColor: Colors.indigo[300],
          ),
          //     ),
          //   ],
          // ),
          SizedBox(width: 10),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 40),
        children: createTodoList(),
      ),
    );
  }
}
