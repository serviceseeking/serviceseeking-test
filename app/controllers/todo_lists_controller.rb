class TodoListsController < ApplicationController

  def index
  end

  def show
    @todo_list = TodoList.find(params[:id])
  end

  def new
    form TodoList::Create
  end

  def edit
    form TodoList::Update
  end
  
  def create
    run TodoList::Create do
      return redirect_to todo_lists_path, notice: "Todo List successfully created!"
    end

    redirect_to todo_lists_path, "Name can't be blank"
  end

  def update
    run TodoList::Update do |op|
      return redirect_to todo_lists_path, notice: "Todo List successfully updated!"
    end

    redirect_to todo_lists_path, "Name can't be blank"
  end

  def destroy
    @todo_list = TodoList.find(params[:id])
    @todo_list.destroy
    redirect_to todo_lists_path, notice: "Todo List was successfully deleted!"
  end
end
