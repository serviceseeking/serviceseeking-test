class Todo::Update < Trailblazer::Operation
	def process(params)
		title = params[:todo][:title] || ''
		description = params[:todo][:description] || ''
		id = params[:todo][:id] || 0
		todo = Todo.find(id)
		@valid = todo.update_attributes({title: title, 
			description: description})
	end
end