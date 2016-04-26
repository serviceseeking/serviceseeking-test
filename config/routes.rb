Rails.application.routes.draw do
  root to: 'todos#new'

  resources :todo_lists do
    resources :todos
  end

  resources :todos, only: [:create, :new, :show]

  post '/' => "todos#create"
  get '/sign_up' =>  'session#sign_up'
  post '/sign_up' =>  'session#create_user'
  get '/sign_in' => 'session#sign_in'
  get '/log_out' => 'session#log_out'
  post '/sign_in' => 'session#authenticate'
end
