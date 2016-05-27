class Todo::Create < Trailblazer::Operation
  include Model
  model Todo, :create

  contract do
    property :title, validates: {presence: true}
    property :todo_list_id
  end

  def process(params)
    validate(params[:todo], @model) do |f|
      todo_list = get_todo_list(params[:todo_list_id])
      f.todo_list_id = todo_list.id
      f.save
    end
  end

  private

  def get_todo_list(todo_list_id)
    if todo_list_id.blank?
      todo_list = TodoList.find_by_name("Default To-do List")
      if todo_list.blank?
        todo_list = TodoList::Create.(todo_list: { name: "Default To-do List" }).model
      end
    else
      todo_list = TodoList.find(todo_list_id)
    end
    return todo_list
  end

end
