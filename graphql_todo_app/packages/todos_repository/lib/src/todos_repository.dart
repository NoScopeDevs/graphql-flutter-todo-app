import 'package:todos_repository/todos_repository.dart';

/// {@template todos_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class TodosRepository {
  /// {@macro todos_repository}
  const TodosRepository(TodosApi todosApi) : _todosApi = todosApi;

  final TodosApi _todosApi;

  Stream<List<Todo>> todosStream() => _todosApi.todosStream();

  Future<Map<String, Todo>> getTodos() => _todosApi.getTodos();

  Future<Todo> saveTodo(Todo todo) => _todosApi.saveTodo(todo);

  Future<void> deleteTodo(String id) => _todosApi.deleteTodo(id);
}
