// Code generated by github.com/99designs/gqlgen, DO NOT EDIT.

package model

type Todo struct {
	ID          string `json:"id"`
	Text        string `json:"text"`
	IsCompleted bool   `json:"isCompleted"`
}

type TodoInput struct {
	ID          *string `json:"id,omitempty"`
	Text        string  `json:"text"`
	IsCompleted *bool   `json:"isCompleted,omitempty"`
}
