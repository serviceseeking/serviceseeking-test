class TodoListsController < ApplicationController
  def index
    if current_user then
      @todo_lists = TodoList.where(user_id: current_user.id)
    else
      @todo_lists =  []
    end
  end

  def show
    @todo_list_id = params[:id]
    @todos = Todo.where(todo_list_id: params[:id])
  end

  def new
    form TodoList::Create
  end

  def edit
    form TodoList::Update
  end

  def destroy
    run TodoList::Delete do
      return redirect_to todo_lists_path, notice: "Todo List was deleted!"
    end

    render :index
  end

  def update
    run TodoList::Update do
      return redirect_to todo_lists_path, notice: "Todo List was updated!"
    end

    render :new
  end

  def create
    @current_user = current_user || Session::CreateGuestUser.({}).model
    log_in(@current_user) if current_user.nil?

    params[:todo_list].merge!({user_id: @current_user.id})
    run TodoList::Create do
      redirect_to todo_list_path(@model)
      return
    end

    render :new
  end
end
