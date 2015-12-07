class TodosController < ApplicationController
	def index
	end

	def list
	end

	def create
		params.merge!(user_id: current_user.id)
		run Todo::Create do |op|
			return redirect_to(list_path)
		end
		error_messages_to_flash(@operation.contract.errors.messages)
		render :list
	end


	def edit
		@todo = Todo.find(params[:id])
	end


	def update_todo
		run Todo::Update do |op|
			return redirect_to(list_path)
		end
		error_messages_to_flash(@operation.contract.errors.messages)
		render :list
	end

	def destroy
		run Todo::Destroy do |op|
			return redirect_to(list_path)
		end
		error_messages_to_flash(@operation.contract.errors.messages)
		render :list
	end

	private

		def error_messages_to_flash(error_messages)
			error_messages.each do |k,v|
				flash[k] = "#{k.to_s} #{v.join}"
			end
		end
end
