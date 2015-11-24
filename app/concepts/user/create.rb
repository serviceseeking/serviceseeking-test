class User::Create < Trailblazer::Operation
	def process(params)
		username = params[:user][:username]
		password = params[:user][:password]
		fullname = params[:user][:fullname]

		@model = User.new({
				username: username,
				fullname: fullname
			})
		@model.encrypt_password(password)
		@valid = @model.save
	end
end