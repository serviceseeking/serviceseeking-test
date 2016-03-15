class Todo::Create < Trailblazer::Operation
  include Model
  model Todo, :create

  contract do
    property :title, validates: {presence: true}
  end

  def process(params)
    validate(params[:todo]) do |f|
      f.save

      tlid, cuid = params[:todo_list_id], params[:current_user_id]
      model.list = find_or_create_todo_list(tlid, cuid)
    end
  end

  def find_or_create_todo_list(tlid, cuid)
    params = todo_list_params(tlid, cuid)
    TodoList::Create.(params).model
  end

  def todo_list_params(tlid, cuid)
    {
      todo_list: {
        id: tlid,
        user_id: cuid,
      },
    }
  end

end
