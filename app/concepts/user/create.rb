class User::Create < Trailblazer::Operation
  include Model
  model User, :create

  contract do
    property :username
    property :fullname
  end

  def process(params)
    validate(params[:user]) do
      contract.fullname ||= "Guest"
      contract.save
    end
    invalid!
  end
end

