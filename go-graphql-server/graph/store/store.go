package store

import (
	"context"
	"go-graphql-server/graph/model"
	"net/http"

	"github.com/google/uuid"
)

type Store struct {
	Todos []*model.Todo
}

func NewStore() *Store {
	store := make([]*model.Todo, 0)
	return &Store{
		Todos: store,
	}
}

// AddTodo - add todo to store
func (s *Store) AddTodo(t *model.NewTodo) (*model.Todo, error) {
	uuid, err := uuid.NewRandom()
	if err != nil {
		return nil, err
	}

	todo := &model.Todo{
		ID:   uuid.String(),
		Text: t.Text,
		Done: false,
	}

	s.Todos = append(s.Todos, todo)

	return todo, nil
}

// DeleteTodo - delete todo from store
func (s *Store) DeleteTodo(id string) (*model.Todo, error) {
	var todo *model.Todo

	for i, t := range s.Todos {
		if t.ID == id {
			todo = t
			s.Todos = append(s.Todos[:i], s.Todos[i+1:]...)
			break
		}
	}

	return todo, nil
}

// ToggleTodoDone - toggle todo done
func (s *Store) ToggleTodoDone(id string) (*model.Todo, error) {
	var todo *model.Todo

	for _, t := range s.Todos {
		if t.ID == id {
			todo = t
			todo.Done = !todo.Done
			break
		}
	}

	return todo, nil
}

type StoreKeyType string

var StoreKey StoreKeyType = "STORE"

// WithStore middle - inject store into context
func WithStore(store *Store, next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		reqWithStore := r.WithContext(context.WithValue(r.Context(), StoreKey, store))
		next.ServeHTTP(w, reqWithStore)
	})
}

// GetStoreFromContext - get store from request context
func GetStoreFromContext(ctx context.Context) *Store {
	store, ok := ctx.Value(StoreKey).(*Store)

	if !ok {
		panic("Could not get store from context")
	}

	return store
}
