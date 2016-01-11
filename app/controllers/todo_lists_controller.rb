class TodoListsController < ApplicationController
  def index
    @todo_lists = TodoList.all
  end

  def show
    @todo_list = TodoList.find(params[:id])
  end

  def new
    @todo_list = TodoList.new
  end

  def edit
    @todo_list = Todolist.find(params[:id])
  end
  
  def create
    @todo_list = TodoList.new(todo_list_params)
    if @todo_list.save
      redirect_to todo_lists_path, notice: "Todo list was created successfully."
    else
      render :new
    end
  end

  def update
    @todo_list = TodoList.find(params[:id])
    if @todo_list.update_attributes(todo_list_params)
      redirect_to todo_lists_path, notice: "Todo list was updated successfully."
    else
      render :edit
    end
  end

  def destroy
    TodoList.find(params[:id]).destroy
    redirect_to todo_lists_path
  end

  private

  def todo_list_params
    params.require(:todo_list).permit(:name)
  end

end
