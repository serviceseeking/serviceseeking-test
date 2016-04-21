require 'bcrypt'
module Session
  class Login < Trailblazer::Operation
    include Model
    include BCrypt
    model User

    contract do
      undef :persisted?

      attr_reader :user

      property :username, virtual: true
      property :password, virtual: true

      validates :username, presence: true
      validates :password, presence: true
      validate :password_ok?

      private
      def password_ok?
        return if username.blank? || password.blank?

        @user = User.find_by(username: username)
        errors.add(:login, "Invalid credentials") unless @user and Password.new(@user.password_hash) == password
      end
    end

    # TOOD update the username case to downcase
    def process(params)
      validate(params[:user]) do |contract|
        @model = contract.user
      end
    end
  end

  class Create < Trailblazer::Operation
    include Model
    include BCrypt
    include Dispatch
    model User, :create

    contract do
      property :username
      property :fullname
      property :password, virtual: true
      property :confirm_password, virtual: true

      validate :username_ok?
      validate :password_ok?
      validate :password_match?
      validates :fullname, presence: true
      validates :username, presence: true
      validates :password, presence: true

      private
      # check for unique username
      def username_ok?
        return if !User.where(username: username).exists?

        errors.add(:username, 'is not avaliable')
      end

      # check and make sure the password and confirmation match
      def password_match?
        return if password == confirm_password

        errors.add(:password, 'does not match confirmation')
      end

      # check the format of the password
      def password_ok?
        return if password =~ /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,}/

        errors.add(:password, "Minimum 8 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet and 1 Number")
      end
    end

    def process(params)
      self.password = params[:user][:password]

      validate(params[:user]) do
        contract.save
      end
    end

    # hash the password
    def password=(password)
      @model.password_hash = Password.create(password)
    end
  end

  class Delete < Trailblazer::Operation
    include Model
    include Dispatch
    model User, :find

    def process(params)
      @user_id = params[:id]
      model.destroy
    end
  end

  class Find < Trailblazer::Operation
    include Model
    model User, :find

    def process(params)
    end
  end

  class CreateGuestUser < Trailblazer::Operation
    include Model
    include BCrypt
    model User, :create

    def process(params)
      model.username = self.create_guest_username
      model.fullname = "Guest User"
      #TODO actually create a random password
      self.password = "somerandompassword"
      model.save
    end

    def create_guest_username
      "guest" + (User.where("username LIKE 'guest%'").order(username: :desc).first_or_create.username.to_s.scan(/\d/).join().to_i + 1).to_s
    end

    # hash the password
    def password=(password)
      @model.password_hash = Password.create(password)
    end
  end
end
