class User::Create < Trailblazer::Operation
  include Model
  model User

  def process(params)
    @model = User.new
    @model.fullname = "Guest"
    @model.save
    return @model
  end
  
end
