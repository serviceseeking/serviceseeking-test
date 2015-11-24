class Todo::Create < Trailblazer::Operation
	def process(params)
		title = params[:title] || ''
		description = params[:description] || ''
		user = User.find(params[:user_id])
		@valid = user.todos.create({title: title, 
			description: description})
	end
end