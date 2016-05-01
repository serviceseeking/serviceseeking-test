class Todo::Create < Trailblazer::Operation
  include Model
  model Todo, :create

  contract do
    property :title
    property :todo_list_id

    validates :title, presence: true
  end

  def process(params)
    validate(params[:todo]) do |f|
      f.todo_list_id = associate_list(params[:todo_list_id])
      f.save
    end
  end

  private

  def associate_list(todo_list_id)
    return todo_list_id if todo_list_id.present?

    default_todo = TodoList.where(name: 'Default To-do List').first
    return default_todo.id if default_todo.present?

    todo_list_attr = { name: 'Default To-do List' }
    TodoList::Create.(todo_list: todo_list_attr).model.id
  end
end