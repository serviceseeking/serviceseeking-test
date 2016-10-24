Rails.application.routes.draw do

  root to: 'sessions#sign_in'

  resources :todo_lists do
    #resources :todos, only: %i(new create)
    member do
    	post :create_todo
    end
  end

  resources :todos, only: [:new, :create]

  namespace "sessions" do
  	get "sign_up"
  	post "signing_up"
  	get "sign_out"
  	get "sign_in"
  	post "signing_in"
  end
 

end
