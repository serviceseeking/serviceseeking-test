Rails.application.routes.draw do
  root to: 'pages#index'

  resources :todo_lists do
    resources :todos
  end

  resources :todos
end
