import 'package:http/http.dart' as http;
import 'package:todo_list/models/todo_model.dart';
import 'dart:convert';

Future fetchTodoList() async {
  final response = await http.get(
    'http://117.193.68.204:8000/get/todo/123456',
    headers: {"Accept": "application/json"},
  );

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Get request failed');
  }
}

Future markTodo(Todo todo) async {
  Todo updatedTodo = Todo(
    id: todo.id,
    todo: todo.todo,
    completed: !todo.completed,
  );

  final response = await http.put(
    'http://117.193.68.204:8000/change/todo/123456',
    headers: {
      "Content-type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
    },
    body: json.encode(updatedTodo.toMap()),
  );
  print(response.statusCode);

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Get request failed');
  }
}
