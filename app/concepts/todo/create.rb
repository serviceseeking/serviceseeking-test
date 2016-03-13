class Todo::Create < Trailblazer::Operation
  contract do
    property :title, validates: {presence: true}
  end

  def process(params)
    @model = Todo.new

    validate(params[:todo], @model) do |f|
      find_or_create_todo_list(params[:todo_list_id])
      find_or_create_user(params[:current_user_id])
      f.save
    end
  end

  def find_or_create_todo_list(todo_list_id)
    todo_list = if todo_list_id
                  TodoList.find(todo_list_id)
                else
                  TodoList.find_or_create_by(name: "Default To-do List")
                end

    @model.list = todo_list
  end

  def find_or_create_user(current_user_id)
    user = if current_user_id
             User.find(current_user_id)
           else
             User.find_or_create_by(fullname: "Guest")
           end

    todo_list = @model.list
    todo_list.user = user
  end

end
