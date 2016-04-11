class User::Find < Trailblazer::Operation

  def process(params)
    model.save!
  end

  def model!(params)
    if params[:current_user_id].blank?
      User.create!(fullname: "Guest")
    else
      User.find(params[:current_user_id])
    end
  end

end