class TodoList::Create < Trailblazer::Operation
  include Model
  model TodoList, :create

  contract do
    property :name
    property :user_id

    validates :name, presence: true
  end

  def process(params)
    validate(params[:todo_list]) do |f|
      f.user_id = check_user(params)
      f.save
    end
  end

  private

  def check_user(params)
    return params[:current_user_id] unless params[:current_user_id].blank?

    if params[:current_user].present?
      return params[:current_user].id
    else
      return User::Create.(user: { fullname: "Guest" }).model.id
    end
  end
end
