class User::Check < Trailblazer::Operation
  include Model
  model User

  def process(params)
    @model = User.find_or_create_by(fullname: params[:todo][:fullname])
  end
end
