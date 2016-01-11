class WelcomeController < ApplicationController
	def index
		if current_user
			return redirect_to(todos_main_path)
		end
	end

	def login
		run User::Login do |op|
			session[:user_id] = op.model.id
			return redirect_to(todos_main_path)
		end
		flash[:error] = 'Authenthication Failed!'
		render :index
	end

	def signup
	end

	def signup_new_user
		run User::Create do |op|
			session[:user_id] = op.model.id
			return redirect_to(todos_main_path)
		end
		flash[:error] = 'User signup failed!'
		render :signup
	end

	def logout
		session[:user_id] = nil
		render :index
	end

end
