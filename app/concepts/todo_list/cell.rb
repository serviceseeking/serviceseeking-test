class TodoList::Cell < Cell::Concept

  def show
    @todo_list_id = params[:id]
    render 
  end

  def index
    render :index
  end

end
