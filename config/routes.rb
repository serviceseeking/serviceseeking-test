Rails.application.routes.draw do
  root to: 'pages#index'

  resources :todo_lists
  resources :todos
  resources :users
end
