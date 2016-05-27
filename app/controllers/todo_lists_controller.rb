class TodoListsController < ApplicationController

  def index
    @todo_lists = TodoList.all
  end

  def show
    @todo_list = TodoList.find(params[:id])
  end

  def create
    run TodoList::Create do
      return redirect_to @model, notice: "To-do list was successfully created!"
    end

    flash.now[:alert] = "Missing todo list name"
    render :new
  end

  private

  def todo_list_params
    params.require(:todo_list).permit(:name)
  end

end
