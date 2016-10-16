module Shared::Common
  private

  def current_user(params)
    # Find or create the owner of the todo_list:
    ##### If current_user_id is present, fetch that user
    ##### otherwise, create a new one
    if params[:current_user].to_s.blank?
      if params[:current_user_id].to_s.blank?
        User::Create.(user: {}).model
      else
        User.find(params[:current_user_id])
      end
    else
      params[:current_user]
    end
  end
end
