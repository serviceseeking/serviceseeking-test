class Todo::Destroy < Trailblazer::Operation

	contract do 
		def prepopulate!(options)
			@model = Todo.find(options[:id])
		end
	end

	def process(params)
		if @contract.model
			@valid = @contract.model.destroy
		else
			@valid = false
		end
	end
end