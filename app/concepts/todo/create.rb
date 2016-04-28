class Todo::Create < Trailblazer::Operation
  contract do
    property :title, validates: { presence: true }
    property :description, validates: { presence: true }
  end

  def process(params)
    if params[:todo]
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

      todo_list.user = current_user
      todo_list.save!
      todo.list = todo_list
      todo.save!
    else
      return invalid!
    end
  end
end
