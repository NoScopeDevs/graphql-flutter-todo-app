part of 'todos_bloc.dart';

class TodosState {
  TodosState([this.todos = const {}]);

  final Map<String, Todo> todos;
}
