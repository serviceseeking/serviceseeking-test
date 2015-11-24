class User < ActiveRecord::Base
	has_many :todos

	def authenticate(password)
		hash = BCrypt::Engine.hash_secret(password, self.password_salt)
		self.password_hash == hash	
	end

	def encrypt_password(password)
		self.password_salt = BCrypt::Engine.generate_salt
		self.password_hash = BCrypt::Engine.hash_secret(password, self.password_salt)
	end

end
