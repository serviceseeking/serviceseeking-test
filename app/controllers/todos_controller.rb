class TodosController < ApplicationController
	def index
	end

	def list
	end

	def create
		params.merge!(current_user: current_user)
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
		form Todo::Destroy, id: params[:id]
		result, contract = @operation.run
		if result
			return redirect_to(list_path)
		end
		render :list
	end

	private

		def error_messages_to_flash(error_messages)
			error_messages.each do |k,v|
				flash[k] = "#{k.to_s} #{v.join}"
			end
		end
end
