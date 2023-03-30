import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_todo_app/todos/todos.dart';
import 'package:todos_repository/todos_repository.dart';

void main() {
  runApp(
    RepositoryProvider(
      create: (context) => TodosRepository(
        GraphQlTodosApi(graphqlUri: 'http://localhost:8080/query'),
      ),
      child: const MaterialApp(home: TodosPage()),
    ),
  );
}
