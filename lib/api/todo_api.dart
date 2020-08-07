import 'package:http/http.dart' as http;

Future fetchTodoList() async {
  final response = await http.get(
    'http://117.207.19.113:8000/get/todo/123456',
    headers: {"Accept": "application/json"},
  );

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Get request failed');
  }
}
