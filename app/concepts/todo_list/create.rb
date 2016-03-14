class TodoList::Create < Trailblazer::Operation
  include Model
  model TodoList, :create

  def process(params)
    id, uid = params[:todo_list][:id], params[:todo_list][:user_id]
    @model = if id
               TodoList.find(id)
             else
               TodoList.find_or_create_by(name: "Default To-do List")
             end

    find_or_create_user(uid)
  end

  def find_or_create_user(uid)
    params = user_params(uid)
    result = User::Create.(params)

    @model.user = result.model
  end

  def user_params(uid)
    {
      user: {
        id: uid,
      },
    }
  end

end
