class Todo::Destroy < Trailblazer::Operation
	def process(params)
		id = params[:id] || 0
		todo = Todo.find(id)
		@valid = todo.destroy
	end
end