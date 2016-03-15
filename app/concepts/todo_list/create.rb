class TodoList::Create < Trailblazer::Operation
  include Model
  model TodoList, :create

  contract do
    property :name
    property :user_id
  end

  def process(params)
    validate(params[:todo_list]) do |f|
      id, uid = params[:todo_list][:id], params[:todo_list][:user_id]
      @model = TodoList.find_by_id(id) ||
        TodoList.find_or_create_by(name: "Default To-do List")
      @model.user = find_or_create_user(uid)
    end
  end

  def find_or_create_user(uid)
    params = user_params(uid)
    User::Create.(params).model
  end

  def user_params(uid)
    {
      user: {
        id: uid,
      },
    }
  end

end
