class User::Create < Trailblazer::Operation
  include Model
  model User, :create

  contract do
    property :id
    validates :id, presence: true
  end

  attr_accessor :user

  def process(params)

    if(validate(params))

      @user = User.find(params[:id])
    
    else
      
      @user = User.create!(fullname: "Guest")
    
    end
    
  end





end