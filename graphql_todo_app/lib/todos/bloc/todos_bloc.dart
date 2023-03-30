import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_repository/todos_repository.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc(TodosRepository todosRepository)
      : _todosRepository = todosRepository,
        super(TodosState()) {
    on<TodosFetched>(_onTodosFetched);
    on<TodoSaved>(_onTodoSaved);
    on<TodoDeleted>(_onTodoDeleted);
  }

  final TodosRepository _todosRepository;

  Future<void> _onTodosFetched(
    TodosFetched event,
    Emitter<TodosState> emit,
  ) async {
    emit(TodosState(await _todosRepository.getTodos()));
  }

  Future<void> _onTodoSaved(
    TodoSaved event,
    Emitter<TodosState> emit,
  ) async {
    final todo = await _todosRepository.saveTodo(event.todo);
    final todos = Map<String, Todo>.from(state.todos)..[todo.id!] = todo;
    emit(TodosState(todos));
  }

  Future<void> _onTodoDeleted(
    TodoDeleted event,
    Emitter<TodosState> emit,
  ) async {
    await _todosRepository.deleteTodo(event.todo.id!);
    final todos = Map<String, Todo>.from(state.todos)..remove(event.todo.id);
    emit(TodosState(todos));
  }
}
