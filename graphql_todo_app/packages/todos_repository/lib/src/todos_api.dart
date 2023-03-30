import 'package:todos_repository/todos_repository.dart';

abstract class TodosApi {
  const TodosApi();

  Stream<List<Todo>> todosStream();

  Future<Map<String, Todo>> getTodos();

  Future<Todo> saveTodo(Todo todo);

  Future<void> deleteTodo(String id);
}
