class TodoListsController < ApplicationController

  def index
    @todo_lists = TodoList.all
  end

  def show
    @todo_list = TodoList.find(params[:id])
  end

  private

  def todo_list_params
    params.require(:todo_list).permit(:name)
  end

end
