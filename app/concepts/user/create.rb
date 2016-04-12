class User::Create < Trailblazer::Operation
  
  def process(params)
   @model =
        if params[:current_user] == nil
          if params[:current_user_id] == nil
            User.create!(fullname: "Guest")
          else
            User.find(params[:current_user_id])
          end
        else
          params[:current_user]
        end
  end
end
