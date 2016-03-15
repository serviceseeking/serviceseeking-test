class Todo::Create < Trailblazer::Operation
  include Model
  model Todo, :create

  contract do
    property :title, validates: {presence: true}
  end

  def process(params)
    validate(params[:todo]) do |f|
      model.list = find_or_create_todo_list(params)
      f.save
    end
  end

  def find_or_create_todo_list(params)
    TodoList::Create.(todo_list_params(params)).model
  end

  def todo_list_params(params)
    {
      todo_list: {
        id: params[:todo_list_id],
        user_id: params[:current_user_id],
      },
    }
  end

end
