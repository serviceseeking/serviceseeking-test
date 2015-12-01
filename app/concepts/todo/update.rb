class Todo::Update < Trailblazer::Operation

	contract do 
		property :title
		property :description

		validates :title, presence: true
		validates :description, presence: true
	end

	def process(params)
		@model = Todo.find(params[:todo][:id])
		validate(params[:todo], @model) do |todo|
			todo.save
		end
		
	end
end