class User::Create < Trailblazer::Operation
  include Model
  model User, :create

  contract do
    property :fullname, validates: {presence: true}
  end

  def process(params)
    validate(params[:user], @model) do |f|
      f.save
    end
  end

end
