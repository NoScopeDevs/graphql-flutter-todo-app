# GraphQL Flutter Todo App

A basic project showcasing a GraphQL API build with [gqlgen](https://gqlgen.com) for the backend and Flutter for the front end using [package:graphql](https://pub.dev/packages/graphql).

## How to run?

To start the server:

```sh
cd go-graphql-server

go run server.go
```

To run the flutter app:
```sh
cd graphql_todo_app

flutter run lib/main.dart
```

## Useful query/mutation for the gql playground

```gql
query getTodos{
  todos {
    id
    text
    isCompleted
  }
}

mutation saveTodo{
  saveTodo(input: {
    # id: "f4ccf8e0-82ba-4cac-b714-a5fd3950d322"
    text: "My Super Todo"
    isCompleted: true
  }) {
    id,
    text,
    isCompleted
  }
}

mutation saveTodoWithVariables($todoInput: TodoInput!) {
	saveTodo(input: $todoInput){
    id
    text
    isCompleted
  }
}

mutation deleteTodo{
  deleteTodo(id: "f4ccf8e0-82ba-4cac-b714-a5fd3950d322"){
    id
    text
	isCompleted
  }
}

```