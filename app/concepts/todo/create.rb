class Todo::Create < Trailblazer::Operation
  include Model
  include Shared::Common

  model Todo, :create

  contract do
    property :title
    property :description
    property :todo_list_id
    validates :title, presence: true
  end

  def process(params)
    @model = Todo.new
    validate(params[:todo]) do
      if contract.todo_list_id.blank?
        todo_list = get_todo_list(params)
        todo_list.user = current_user(params)
        todo_list.save!
      else
        todo_list = TodoList.find(contract.todo_list_id)
      end

      contract.todo_list_id = todo_list.id
      contract.save
    end
    invalid!
  end

  private

  def get_todo_list(params)
    todo_list_name = "Default To-do List"
    unless todo_list = TodoList.where(name: todo_list_name).first
      todo_list = TodoList::Create.(todo_list: {name: todo_list_name}).model
    end
    todo_list
  end
end
