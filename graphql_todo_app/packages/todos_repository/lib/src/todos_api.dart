import 'package:todos_repository/todos_repository.dart';

abstract class TodosApi {
  const TodosApi();

  Stream<List<Todo>> todosStream();

  Future<List<Todo>> getTodos();

  Future<void> saveTodo(Todo todo);

  Future<void> deleteTodo(String id);
}

class TodoNotFoundException implements Exception {}
