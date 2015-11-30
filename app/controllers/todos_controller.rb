class TodosController < ApplicationController
	def index
	end

	def list
	end

	def create
		form Todo::Create , current_user: current_user
		result, contract = @operation.run
		if result
			return redirect_to(list_path)
		end
		render :list
	end


	def edit
		@todo = Todo.find(params[:id])
	end


	def update_todo
		form Todo::Update, id: params[:todo][:id]
		result, contract = @operation.run
		if result
			return redirect_to(list_path)
		end
		render :list
	end

	def destroy
		form Todo::Destroy, id: params[:id]
		result, contract = @operation.run
		if result
			return redirect_to(list_path)
		end
		render :list
	end


end
