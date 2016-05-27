Rails.application.routes.draw do
  root to: 'pages#index'

  resources :todo_lists, only: %i(index show create) do
    resources :todos, only: %i(new create)
  end

  resources :todos, only: :create
end
