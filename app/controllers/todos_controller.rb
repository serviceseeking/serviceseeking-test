class TodosController < ApplicationController
	def index
	end

	def list

	end

	def create
		params[:user_id] = current_user.id
		run Todo::Create do |op|
			return redirect_to(list_path)
		end
		render :list
	end


	def edit
		@todo = Todo.find(params[:id])
	end


	def update_todo
		run Todo::Update do |op|
			return redirect_to(list_path)
		end
		render :list
	end

	def destroy
		run Todo::Destroy do |op|
			return redirect_to(list_path)
		end
		render :list
	end


end
