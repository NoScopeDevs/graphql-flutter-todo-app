import 'package:graphql/client.dart';
import 'package:todos_repository/todos_repository.dart';

class GraphQlTodosApi extends TodosApi {
  GraphQlTodosApi({required String graphqlUri})
      : _graphQLClient = GraphQLClient(
          cache: GraphQLCache(),
          link: HttpLink(graphqlUri),
        );

  final GraphQLClient _graphQLClient;

  @override
  Future<void> deleteTodo(String id) async {
    final mutationString = gql('''
          mutation deleteTodo {
            deleteTodo(id: $id)
          }
        ''');

    await _graphQLClient.mutate(
      MutationOptions(document: mutationString),
    );
  }

  @override
  Future<List<Todo>> getTodos() async {
    final queryString = gql('''
          query {
            todos {
              id
              text
              isCompleted
            }
          }
        ''');

    final result = await _graphQLClient.query(
      QueryOptions(
        document: queryString,
        fetchPolicy: FetchPolicy.networkOnly,
      ),
    );

    if (result.hasException) {
      throw result.exception!;
    }

    final todos = (result.data!['todos'] as List<dynamic>).map(
      (e) => Todo.fromJson(e as Map<String, dynamic>),
    );

    return todos.toList();
  }

  @override
  Future<void> saveTodo(Todo todo) async {
    final mutationString = gql(r'''
          mutation saveTodoWithVariables($todoInput: TodoInput!) {
            saveTodo(input: $todoInput){
              id
              text
              isCompleted
            }
          }
        ''');

    await _graphQLClient.mutate(
      MutationOptions(
        document: mutationString,
        variables: {
          'todoInput': todo.toJson(),
        },
      ),
    );
  }

  @override
  Stream<List<Todo>> todosStream() {
    // TODO: implement todosStream
    throw UnimplementedError();
  }
}
