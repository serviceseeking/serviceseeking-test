Rails.application.routes.draw do
  resources :todo_lists
  resources :todo_lists
  root to: 'todo_lists#index'

  resources :todo_lists
  resources :todos
  resources :users
end
