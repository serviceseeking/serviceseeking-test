class TodoListsController < ApplicationController
  def index
    @todo_lists = TodoList.all
  end

  def show
    @todo_list = TodoList.find(params[:id])
  end

  def new
  end

  def create
    res = run TodoList::Create do
      return redirect_to @model, notice: "List was successfully created!"
    end

    @errors = res.errors.full_messages
    render :new
  end

  private

  def todo_list_params
    params.require(:todo_list).permit(:name)
  end
end
