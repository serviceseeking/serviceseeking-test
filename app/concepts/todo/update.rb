class Todo::Update < Todo::Create
	action :update

	contract do
		property :title

		validates :title, presence: true
	end
end