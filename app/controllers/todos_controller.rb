class TodosController < ApplicationController

  def new
    form Todo::Create
  end

  def show
    @todo = Todo.find_by(params[:id])
  end

  def create
    @current_user = current_user || Session::CreateGuestUser.({}).model
    @todo_list = TodoList.where(id: params[:todo_list_id]).first ||
      TodoList::GetOrCreateDefaultTodoList.({user_id: @current_user.id}).model

    log_in(@current_user) if current_user.nil?

    params[:todo].merge!({todo_list_id: @todo_list.id})

    run Todo::Create do
      redirect_to todo_list_path(id: @model.todo_list_id), notice: "Todo successfully created!"
      return
    end

    render :new
  end

  def destroy
    run Todo::Delete do
      redirect_to todo_list_path(params[:todo_list_id]), notice: 'Todo successfully deleted!'
    end
  end

  def update
    run Todo::Update do
      redirect_to todo_list_path(@model.todo_list_id), notice: 'Todo successfully updated!'
      # fixme, for some reason the redirection does not get triggered sometimes
      # and the render is triggered over again. The return statement fixes this
      return
    end
    render :edit
  end

  def edit
    @model = Todo.find_by(id: params[:id])
  end
end
