class User::Create < Trailblazer::Operation
  include Model
  model User, :create
  
  def process(params)
    user = @model = User.new()
    user.fullname = "Guest"
    user.save
  end
  
end
