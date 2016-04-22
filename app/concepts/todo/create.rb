class Todo::Create < Trailblazer::Operation
  include Model
  model Todo
  
  # validate if the title is blank
  contract do
    property :title, validates: {presence: true}
  end

  def process(params)
    
    todo = @model = Todo.new(params.require(:todo).permit(:title, :description))
    
    validate(params[:todo], @model) do |f|
      todo_list = params[:todo_list_id].blank? ? TodoList::Create.(params).model : TodoList.find(params[:todo_list_id])
      todo.title = f.title
      todo.list = todo_list
      todo.save
    end
  end

end
