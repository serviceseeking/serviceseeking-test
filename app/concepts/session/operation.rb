class Session < ActiveRecord::Base
	class SignUp < Trailblazer::Operation
		include Model
		model User, :create

		contract do
			property :username
			property :password, virtual: true
			property :confirm_password, virtual: true
			property :fullname
			property :password_digest
			
			validates_uniqueness_of :username
			validates :username, :password, :confirm_password, presence: true
			validates :username, :password, length: { in: 6..30 }
			validate :password_ok?

			private

			def password_ok?
				return unless username and password
				return if password == confirm_password
				errors.add(:password, "does not match")
			end
		end

		def process(params) 
			validate(params[:user]) do
				create!
				contract.save 
			end
		end

		def create!
			auth = Tyrant::Authenticatable.new(contract.model) 
			contract.password_digest = auth.digest!(contract.password)
			auth.confirmed!
			auth.sync
		end

		
	end

	class SignIn < Trailblazer::Operation
		contract do
			attr_reader :user

			property :username, virtual: true
			property :password, virtual: true

			validates :username, :password, presence: true 
			validate :password_ok?

			private
			def password_ok?
				return if username.blank? or password.blank?
	            @user = User.find_by(username: username)
	            errors.add(:password, "Wrong password.") unless @user and Tyrant::Authenticatable.new(@user).digest?(password)	
			end
		end

		def process(params)
			validate(params[:session]) do |contract|
				@model = contract.user
			end
		end
	end

	class SignOut < Trailblazer::Operation
	  	def process(params)
	  	end
	end

end