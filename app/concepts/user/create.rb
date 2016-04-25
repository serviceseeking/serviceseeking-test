class User::Create < Trailblazer::Operation
  include Model
  model User, :create

  contract do 
    property :fullname
    validates :fullname, presence: true
  end
  
  def process(params)
    params[:todo][:fullname] = params[:todo][:fullname].blank? ? "Guest" : params[:todo][:fullname]
    validate(params[:todo],@model) do |f|
      f.save
    end
  end
  
end

