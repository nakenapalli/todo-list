import 'package:http/http.dart' as http;
import 'package:todo_list/models/todo_model.dart';
import 'dart:convert';

final String ip = "117.193.65.95";
final int port = 8080;
final int accessCode = 123456;

Future fetchTodoList() async {
  final response = await http.get(
    'http://$ip:$port/get/todo/$accessCode',
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

  final response = await http.post(
    'http://$ip:$port/change/todo/$accessCode',
    headers: {
      "Content-type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
    },
    body: json.encode(updatedTodo.toMap('change')),
  );
  print("${response.statusCode}: ${response.body}");

  return updatedTodo;
}

Future addTodo(Todo todo) async {
  final response = await http.post(
    'http://$ip:$port/add/todo/$accessCode',
    headers: {
      "Content-type": "application/x-www-form-urlencoded",
      "Accept": "application/json",
    },
    body: json.encode(todo.toMap('add')),
  );
  print("${response.statusCode}: ${response.body}");
}
