class Todo < ActiveRecord::Base
	class Create < Trailblazer::Operation
		include Model
		model Todo, :create

		contract do
			property :title
		  	property :description
		  	property :list
		  	property :name, virtual: true
		  	property :current_user_id, virtual: true
		 
		  	validates :title, :description, presence: true
		  	validate :name_ok?

		  	private

			def name_ok?
				puts "=============== #{model.list}"
				return if list.nil? and name.blank?
				
			end
		end

		def process(params)
		  	validate(params[:todo]) do
		  		contract.list.nil? ? (contract.list = create_todo_list) : ""
		    	contract.save
		  	end
		end

		private
		def setup_model!(params)
			unless params[:todo_list_id].nil?
				model.list = TodoList.find_by_id(params[:todo_list_id]) 
			end
		end

		def create_todo_list
			user = signed_in?
			list = TodoList.new(:name => contract.name)
			list.user = user
			list.save!

			return list
		end

		def signed_in?
			unless contract.current_user_id.present?
				user = generate_random_user
				create_user(user)
				user.save!
				user = user
			else
				user = User.find(contract.current_user_id)
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
end