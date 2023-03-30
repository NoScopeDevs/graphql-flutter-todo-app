part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

class TodosFetched extends TodosEvent {}

class TodoSaved extends TodosEvent {
  const TodoSaved(this.todo);

  final Todo todo;

  @override
  List<Object> get props => [todo];
}

class TodoDeleted extends TodosEvent {
  const TodoDeleted(this.todo);

  final Todo todo;

  @override
  List<Object> get props => [todo];
}
