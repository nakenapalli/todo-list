class Todo {
  final int id;
  final String todo;
  final bool completed;

  Todo({this.id, this.todo, this.completed});

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      todo: json['todo'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toMap(String function) {
    switch (function) {
      case 'change':
        {
          return {
            'id': id,
            'completed': completed,
          };
        }
        break;

      case 'add':
        {
          return {
            'completed': false,
            'todo': todo,
          };
        }
        break;

      default:
        {
          print("Invalid function");
          return null;
        }
        break;
    }
  }
}
