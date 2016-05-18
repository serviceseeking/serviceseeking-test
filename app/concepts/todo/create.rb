class Todo::Create < Trailblazer::Operation
  include Model
  model Todo, :create

  contract do
    property :title, validates: {presence: true}
    property :todo_list_id
  end

  def process(params)
    validate(params[:todo], @model) do |f|
      todo_list = get_todo_list(params)
      f.todo_list_id = todo_list.id
      f.save
    end
  end

  private

  def get_todo_list(params)
    if params[:todo_list_id].blank?
      todo_list = TodoList.find_or_create_by(name: "Default To-do List")
      current_user = get_user(params)

      todo_list.user = current_user
      todo_list.save!
    else
      todo_list = TodoList.find(params[:todo_list_id])
    end
    return todo_list
  end

  def get_user(params)
    current_user =
      if params[:current_user] == nil
        if params[:current_user_id] == nil
          User.create!(fullname: "Guest")
        else
          User.find(params[:current_user_id])
        end
      else
        current_user
      end
  end

end
