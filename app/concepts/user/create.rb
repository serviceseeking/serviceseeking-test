class User::Create < Trailblazer::Operation
  include Model
  model User, :create

  contract do
    property :fullname

    validates :fullname, presence: true
  end

  def process(params)
    validate(params[:user]) do |f|
      f.save
    end
  end
end