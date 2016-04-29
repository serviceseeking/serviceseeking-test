class User::Create < Trailblazer::Operation
  include Model
  model User, :create

  def process(params)
    model = find_or_create_user(params)
  end

  def find_or_create_user(params)
    if params[:user][:id].present?
      user = User.find(params[:user][:id])
    else
      user = User.create(fullname: "Guest")
    end
  end
end
