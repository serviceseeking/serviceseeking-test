class Todo::Create < Trailblazer::Operation
	
	contract do 
		def prepopulate!(options)
			@model = options[:current_user] 
		end
	end

	def process(params)
		title = @params[:title] || ''
		description = @params[:description] || ''
		if @contract.model
			@valid = @contract.model.todos.create({title: title, 
				description: description})
		else
			@valid = false
		end
			
	end
end