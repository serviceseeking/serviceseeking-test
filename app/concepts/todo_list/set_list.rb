class TodoList::SetList < Trailblazer::Operation
  contract do
    property :id
  end

  def process(params)
    if params[:todo_list][:id].present?
      @model = TodoList.find(params[:todo_list][:id])
    elsif TodoList.find_by_name(TodoList::DEFAULT_NAME).present?
      @model = TodoList.find_by_name(TodoList::DEFAULT_NAME)
    else
      @model = TodoList::Create.(todo_list: {name: TodoList::DEFAULT_NAME}).model
    end
  end
end