class Todo::Create < Trailblazer::Operation
  include Model
  model Todo, :create

  contract do
    property :title, validates: { presence: true }
    property :list
  end

  def process(params)
    validate(params[:todo]) do |todo_item|
      todo_item.list = create_todo_list(params)
      todo_item.save
    end
  end

  def create_todo_list(params)
    TodoList::Create.(todo_list_params(params)).model
  end

  def todo_list_params(params)
    {
      todo_list: {
        id: params[:todo_list_id],
        user: params[:current_user_id]
      }
    }
  end

end
