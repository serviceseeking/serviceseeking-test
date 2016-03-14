class User::Create < Trailblazer::Operation
  include Model
  model User, :create

  def process(params)
    id = params[:user][:id]
    @model = if id
               User.find(id)
             else
               User.find_or_create_by(fullname: "Guest")
             end
  end

end
