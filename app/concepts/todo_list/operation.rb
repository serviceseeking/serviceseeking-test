class TodoList < ActiveRecord::Base
	class Create < Trailblazer::Operation
		include Model
		model TodoList, :create
		attr_reader :user

		contract do
		  property :name
		  property :current_user_id, virtual: true
		  
		  validates :name, presence: true

		end

		def process(params)
		  validate(params[:todo_list]) do
		  	signed_in?
		    contract.save
		  end
		end

		def signed_in?
			unless contract.current_user_id.present?
				user = generate_random_user
				create_user(user)
				user.save!
				model.user = user
			else
				model.user = User.find(contract.current_user_id)
			end
		end

		def generate_random_user
			User.new(username: Faker::Internet.user_name(6), password_digest: Faker::Internet.password(8), fullname: Faker::Name.name)
		end

		def create_user(user)
			auth = Tyrant::Authenticatable.new(user) 
			user.password_digest = auth.digest!(user.password_digest)
			auth.confirmed!
			auth.sync
		end
	end

	class Update < Create
		action :update

		contract do
			property :id, writeable: false
			property :user_id, writeable: false
		end
	end

	class Show < Trailblazer::Operation
	  	include Model
	  	model TodoList, :find
	  	
	end

	class CreateTodo < Trailblazer::Operation
		include Model
		model Todo, :create

		contract do
			property :title
		  	property :description
		  	property :list
		  	
		  	validates :title, :description, presence: true
		end

		def process(params)
		  	validate(params[:todo]) do
		    	contract.save
		  	end
		end

		private
		def setup_model!(params)
			model.list = TodoList.find_by_id(params[:id]) 
		end
	end
end