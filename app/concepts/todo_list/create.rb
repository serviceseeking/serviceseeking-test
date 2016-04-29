class TodoList::Create < Trailblazer::Operation
  include Model
  model TodoList, :create

  contract do
    property :user_id
    property :name
  end

  def process(params)
    validate(params[:todo_list]) do |todo_list|
      @model = find_or_create_todolist(params)
      @model.user = find_or_create_user(params)
    end
  end

  def find_or_create_todolist(params)
    if params[:todo_list_id].present?
      todo_list = TodoList.find(params[:todo_list_id])
    else
      todo_list = TodoList.find_or_create_by(name: "Default To-do List")
    end
  end

  def find_or_create_user(params)
    if params[:current_user].present?
      user = User.find(params[:current_user_id])
    else
      user = User.create(fullname: "Guest")
    end
  end
end
