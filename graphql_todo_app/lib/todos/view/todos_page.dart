import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:graphql_todo_app/todos/todos.dart';
import 'package:todos_repository/todos_repository.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const TodosPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodosBloc(
        RepositoryProvider.of<TodosRepository>(context),
      )..add(TodosFetched()),
      child: const TodosView(),
    );
  }
}

class TodosView extends StatelessWidget {
  const TodosView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: BlocBuilder<TodosBloc, TodosState>(
        builder: (context, state) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return TodoTile(state.todos.values.toList()[index]);
            },
            itemCount: state.todos.values.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog<void>(
            context: context,
            builder: (_) => BlocProvider.value(
              value: context.read<TodosBloc>(),
              child: const NewTodoDialog(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TodoTile extends StatelessWidget {
  const TodoTile(this.todo, {super.key});

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Slidable(
        key: Key(todo.id!),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                context.read<TodosBloc>().add(TodoDeleted(todo));
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: ListTile(
          leading: Checkbox(
            value: todo.isCompleted,
            onChanged: (_) {
              final updatedTodo = todo.copyWith(isCompleted: !todo.isCompleted);
              context.read<TodosBloc>().add(TodoSaved(updatedTodo));
            },
          ),
          title: Text(todo.text),
        ),
      ),
    );
  }
}

class NewTodoDialog extends StatefulWidget {
  const NewTodoDialog({super.key});

  @override
  State<NewTodoDialog> createState() => _NewTodoDialogState();
}

class _NewTodoDialogState extends State<NewTodoDialog> {
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: textController,
            decoration: const InputDecoration(
              labelText: 'New Todo',
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            context.read<TodosBloc>().add(
                  TodoSaved(Todo(text: textController.text)),
                );
            Navigator.of(context).pop();
          },
          child: const Text('Add'),
        )
      ],
    );
  }
}
