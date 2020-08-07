class Todo {
  int id;
  String todo;
  bool completed;

  Todo({this.id, this.todo, this.completed});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      todo: json['todo'],
      completed: json['completed'],
    );
  }
}
