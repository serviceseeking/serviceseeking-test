class TodoListsController < ApplicationController

  def index
    @todo_lists = TodoList.includes(:todos).all
  end

  def new
    form TodoList::Create
  end

  def create
    run TodoList::Create do
      return redirect_to @model, notice: "To-do List was successfully created!"
    end

    render :new
  end

  def show
    @todo_list = TodoList.find(params[:id])
  end

  private

  def todo_list_params
    params.require(:todo_list).permit(:name)
  end

end
