class User::Create < Trailblazer::Operation
  include Model
  model User, :create

  contract do
    property :fullname
  end

  def process(params)
    validate(params[:user]) do |user|
      @model = User.find_by_id(user.id) ||
        User.find_or_create_by(fullname: "Guest")
    end
  end
end
