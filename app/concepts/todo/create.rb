class Todo::Create < Trailblazer::Operation
  include Model
  model Todo, :create

  contract do
    property :title, validates: {presence: true}
  end

  def process(params)
    tlid, cuid = params[:todo_list_id], params[:current_user_id]
    validate(params[:todo]) do |f|
      find_or_create_todo_list(tlid, cuid)
      f.save
    end
  end

  def find_or_create_todo_list(tlid, cuid)
    params = todo_list_params(tlid, cuid)
    result = TodoList::Create.(params)

    @model.list = result.model
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
