class Todo::Create < Trailblazer::Operation
	
	contract do 
		property :title
		property :description

		validates :title, presence: true
		validates :description, presence: true
	end

	def process(params)
		@model = params[:current_user].todos.new if params[:current_user]
		validate(params.except(:current_user), @model) do |todo|
			todo.save
		end
	end
end