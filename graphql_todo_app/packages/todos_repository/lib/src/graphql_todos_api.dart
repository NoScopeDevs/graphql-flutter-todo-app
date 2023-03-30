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
    final mutationString = gql(r'''
          mutation deleteTodoWithId($input: ID!) {
            deleteTodo(id: $input){
              id
            }
          }
        ''');

    await _graphQLClient.mutate(
      MutationOptions(document: mutationString, variables: {'input': id}),
    );
  }

  @override
  Future<Map<String, Todo>> getTodos() async {
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

    return todos.toList().asMap().map((key, t) => MapEntry(t.id!, t));
  }

  @override
  Future<Todo> saveTodo(Todo todo) async {
    final mutationString = gql(r'''
          mutation saveTodoWithVariables($todoInput: TodoInput!) {
            saveTodo(input: $todoInput){
              id
              text
              isCompleted
            }
          }
        ''');

    final result = await _graphQLClient.mutate(
      MutationOptions(
        document: mutationString,
        variables: {
          'todoInput': todo.toJson(),
        },
      ),
    );

    if (result.hasException) {
      throw result.exception!;
    }

    return Todo.fromJson(result.data!['saveTodo'] as Map<String, dynamic>);
  }

  @override
  Stream<List<Todo>> todosStream() {
    throw UnimplementedError();
  }
}
