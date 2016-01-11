Rails.application.routes.draw do
  root to: 'pages#index'

  resources :todo_lists, only: %i(index show) do
    resources :todos, only: %i(new create)
  end

  resources :todos, only: :create
end
