import 'package:todos_repository/todos_repository.dart';

class TodosRepository {
  const TodosRepository(TodosApi todosApi) : _todosApi = todosApi;

  final TodosApi _todosApi;

  Future<Map<String, Todo>> getTodos() => _todosApi.getTodos();

  Future<Todo> saveTodo(Todo todo) => _todosApi.saveTodo(todo);

  Future<void> deleteTodo(String id) => _todosApi.deleteTodo(id);
}
