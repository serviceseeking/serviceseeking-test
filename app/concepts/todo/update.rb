class Todo::Update < Trailblazer::Operation

	include Model

	model Todo, :update

	contract do 
		property :title
		property :description

		validates :title, presence: true
		validates :description, presence: true
	end

	def process(params)
		validate(params) do |todo|
			todo.save
		end
	end
end