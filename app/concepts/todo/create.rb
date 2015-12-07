class Todo::Create < Trailblazer::Operation
	
	include Model

	model Todo, :create

	contract do 
		property :title
		property :description
		property :user_id

		validates :title, presence: true
		validates :description, presence: true
		validates :user_id, presence: true
	end

	def process(params)
		validate(params) do |todo|
			todo.save
		end
	end
end