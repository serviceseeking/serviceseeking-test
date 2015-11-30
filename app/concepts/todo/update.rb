class Todo::Update < Trailblazer::Operation

	contract do 
		def prepopulate!(options)
			@model = Todo.find(options[:id])
		end
	end

	def process(params)
		title = @params[:todo][:title] || ''
		description = @params[:todo][:description] || ''
		if @contract.model
			@valid = @contract.model.update_attributes({title: title, 
				description: description})
		else
			@valid = false
		end
	end
end