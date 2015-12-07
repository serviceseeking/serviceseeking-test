class Todo::Destroy < Trailblazer::Operation

	include Model

	model Todo, :update

	def process(params)
		validate(params) do |todo|
			@model.destroy
		end		
	end
end