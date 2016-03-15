class User::Create < Trailblazer::Operation
  include Model
  model User, :create

  contract do
    property :id
    property :fullname
  end

  def process(params)
    validate(params[:user]) do |f|
      @model = User.find_by_id(f.id) ||
        User.find_or_create_by(fullname: "Guest")
    end
  end

end
