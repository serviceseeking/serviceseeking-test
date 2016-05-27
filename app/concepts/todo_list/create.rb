class TodoList::Create < Trailblazer::Operation
  include Model
  model TodoList, :create

  contract do
    property :name, validates: {presence: true}
    property :user_id
  end

  def process(params)
    validate(params[:todo_list], @model) do |f|
      user = get_user(params)
      f.user_id = user.id
      f.save
    end
  end

  private

  def get_user(params)
    if params[:current_user] == nil
      if params[:current_user_id] == nil
        current_user = User::Create.(user: { fullname: "Guest" }).model
      else
        current_user = User.find(params[:current_user_id])
      end
    else
      current_user = params[:current_user]
    end
    return current_user
  end

end
