package graph

// This file will be automatically regenerated based on the schema, any resolver implementations
// will be copied through when generating and any unknown code will be moved to the end.
// Code generated by github.com/99designs/gqlgen version v0.17.27

import (
	"context"
	"go-graphql-server/graph/model"
	"go-graphql-server/graph/store"
)

// CreateTodo is the resolver for the createTodo field.
func (r *mutationResolver) CreateTodo(ctx context.Context, input model.NewTodo) (*model.Todo, error) {
	db := store.GetStoreFromContext(ctx)

	todo, err := db.AddTodo(&input)

	if err != nil {
		return nil, err
	}

	return todo, nil
}

// DeleteTodo is the resolver for the deleteTodo field.
func (r *mutationResolver) DeleteTodo(ctx context.Context, id string) (*model.Todo, error) {
	db := store.GetStoreFromContext(ctx)

	todo, err := db.DeleteTodo(id)

	if err != nil {
		return nil, err
	}

	return todo, nil
}

// ToggleTodoDone is the resolver for the toggleTodoDone field.
func (r *mutationResolver) ToggleTodoDone(ctx context.Context, id string) (*model.Todo, error) {
	db := store.GetStoreFromContext(ctx)

	todo, err := db.ToggleTodoDone(id)

	if err != nil {
		return nil, err
	}

	return todo, nil
}

// Todos is the resolver for the todos field.
func (r *queryResolver) Todos(ctx context.Context) ([]*model.Todo, error) {
	db := store.GetStoreFromContext(ctx)
	return db.Todos, nil
}

// Mutation returns MutationResolver implementation.
func (r *Resolver) Mutation() MutationResolver { return &mutationResolver{r} }

// Query returns QueryResolver implementation.
func (r *Resolver) Query() QueryResolver { return &queryResolver{r} }

type mutationResolver struct{ *Resolver }
type queryResolver struct{ *Resolver }