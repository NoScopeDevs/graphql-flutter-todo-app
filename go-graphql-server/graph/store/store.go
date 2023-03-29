package store

import (
	"context"
	"errors"
	"go-graphql-server/graph/model"
	"net/http"

	"github.com/google/uuid"
)

type Store struct {
	Todos map[string]*model.Todo
}

func NewStore() *Store {
	store := make(map[string]*model.Todo)
	return &Store{
		Todos: store,
	}
}

// SaveTodo - saves or updates todo in store
func (s *Store) SaveTodo(input *model.TodoInput) (*model.Todo, error) {
	var id string
	var isCompleted bool
	if input.ID == nil {
		uuid, err := uuid.NewRandom()
		id = uuid.String()
		if err != nil {
			return nil, err
		}
	} else {
		id = *input.ID
	}

	if input.IsCompleted == nil {
		isCompleted = false
	} else {
		isCompleted = *input.IsCompleted
	}

	todo := &model.Todo{
		ID:          id,
		Text:        input.Text,
		IsCompleted: isCompleted,
	}

	s.Todos[id] = todo

	return todo, nil
}

// DeleteTodo - delete todo from store
func (s *Store) DeleteTodo(id string) (*model.Todo, error) {

	todo := s.Todos[id]

	if todo != nil {
		delete(s.Todos, id)
		return todo, nil
	}

	// return error not found
	return nil, errors.New("Todo not found")

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
