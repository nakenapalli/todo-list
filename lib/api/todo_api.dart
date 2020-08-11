import 'package:http/http.dart' as http;
import 'package:todo_list/models/todo_model.dart';
import 'dart:convert';

final String ip = "117.193.65.191";
final String port = "10002";
String accessCode = "123456";

Future fetchTodoList() async {
  print("Access code: $accessCode");

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
  print("Access code: $accessCode");

  Todo updatedTodo = Todo(
    id: todo.id,
    todo: todo.todo,
    completed: !todo.completed,
  );

  final response = await http.post(
    'http://$ip:$port/change/todo/$accessCode',
    headers: {
      "Content-type": "application/json",
      "Accept": "application/json",
    },
    body: json.encode(updatedTodo.toMap('change')),
  );
  print("${response.statusCode}: ${response.body}");

  return updatedTodo;
}

Future addTodo(Todo todo) async {
  print("Access code: $accessCode");

  final response = await http.post(
    'http://$ip:$port/add/todo/$accessCode',
    headers: {
      "Content-type": "application/json",
      "Accept": "application/json",
    },
    body: json.encode(todo.toMap('add')),
  );
  print("${response.statusCode}: ${response.body}");
}

Future login(String email, String password) async {
  final response = await http.post(
    'http://$ip:$port/login',
    headers: {
      "Content-type": "application/json",
      "Accept": "application/json",
    },
    body: json.encode({
      "email": email,
      "password": password,
    }),
  );
  print("${response.statusCode}: ${response.body}");

  var data = json.decode(response.body);
  if (data.containsKey("error_message")) {
    throw "Login unauthorized";
  } else {
    return data["token"];
  }
}
