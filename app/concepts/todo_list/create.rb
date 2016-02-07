class TodoList::Create < Trailblazer::Operation
	include Model
	model TodoList, :create

	contract do
		property :name

		validates :name, presence: true
	end

	def process(params)
		validate(params[:todo_list]) do |f|
			f.save
		end
	end
end