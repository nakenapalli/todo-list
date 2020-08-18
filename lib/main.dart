import 'package:flutter/material.dart';
import 'package:todo_list/ui/login_page.dart';
import 'package:todo_list/ui/todo_list.dart';
import 'package:todo_list/ui/new_todo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: generateRoute,
      initialRoute: '/',
    );
  }
}

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => LoginPage());
    case '/list':
      return MaterialPageRoute(builder: (_) => TodoList());
    case '/new':
      return MaterialPageRoute(builder: (_) => NewTodo());
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}
