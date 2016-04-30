class User::SetUser < Trailblazer::Operation 
  contract do
    property :id
  end

  def process(params)
    if params[:current_user_id].present?
      @model = params[:current_user_id]      
    elsif params[:user][:id].nil?
      @model = User.new
      @model.fullname = User::DEFAULT_FULLNAME
      @model.save
    else
      @model = User.find(params[:current_user_id])
    end
  end
end