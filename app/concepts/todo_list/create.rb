class TodoList::Create < Trailblazer::Operation
  include Model
  model TodoList, :create

  contract do
    property :user_id
    property :name
  end

  def process(params)
    validate(params[:todo_list]) do |todo_list|
      model = find_or_create_todolist(params)
      model.user = find_or_create_user(params)
    end
  end

  def find_or_create_todolist(params)
    if params[:todo_list][:id].present?
      todo_list = TodoList.find(params[:todo_list][:id])
    else
      todo_list = TodoList.find_or_create_by(name: "Default To-do List")
    end
  end

  def find_or_create_user(params)
    User::Create.(user_params(params)).model
  end

  def user_params(params)
    {
      user: {
        id: params[:todo_list][:user_id]
      }
    }
  end
end
