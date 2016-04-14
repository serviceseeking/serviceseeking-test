class Todo::Create < Trailblazer::Operation
  contract do
    property :title, validates: {presence: true}
    property :description, validates: {presence: true}
  end
  # Logic for creating a TODO
  #     if `todo_list` is specified
  #         create the `todo`
  #         associated with `todo_list`
  #     else
  #         create the `todo`
  #         create a `user`
  #         create a default `todo_list`
  #         associate `todo_list` with `user`
  #         associate `todo` with `todo_list`
  def process(params)

  if validate(params[:todo])
    todo = @model = Todo.new(params[:todo])
    todo_list = TodoList.find_or_create_by(name: "Default To-do List")
    current_user =
        if params[:current_user] == nil
          if params[:current_user_id] == nil
            User.create!(fullname: "Guest")
          else
            User.find(params[:current_user_id])
          end
        else
          params[:current_user]
        end

    # assign the todo_list to the user
    todo_list.user = current_user
    todo_list.save!
    todo.list = todo_list
    todo.save!
  else
    return invalid!
  end

  end

end
