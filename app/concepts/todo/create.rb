class Todo::Create < Trailblazer::Operation
  include Model
  model Todo, :create

  contract do
    property :title
    property :description
    property :todo_list_id

    validates :title, presence: true
  end

  def process(params)
    validate(params[:todo]) do |f|
      f.todo_list_id = check_todo_list(params[:todo_list_id])
      f.save
    end
  end

  private

  def check_todo_list(todo_list_id)
    return todo_list_id unless todo_list_id.blank?

    parent_list = TodoList.where(name: "Default To-do List").last
    if parent_list.present?
      return parent_list.id
    else
      return TodoList::Create.(todo_list: { name: "Default To-do List" }).model.id
    end
  end
end
