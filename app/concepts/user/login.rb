class User::Login < Trailblazer::Operation
	def process(params)
		username =  params[:login][:username]
		password = params[:login][:password]
		@model = User.find_by_username(username)
		@valid = false
		if @model
			@valid = @model.authenticate(password)
		end
	end
end