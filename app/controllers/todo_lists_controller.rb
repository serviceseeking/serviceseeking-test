class TodoListsController < ApplicationController

  def index
    @todo_lists = TodoList.all
  end

  def new
    #@todo_list = TodoList.new
    form TodoList::Create
  end

  def create
    run TodoList::Create do |op|
      return redirect_to op.model, notice: "To-do List was successfully created!"
    end

    form TodoList::Create
    flash[:alert] = "Name must not be blank."
    render action: :new
  end

  def show
    #@todo_list = TodoList.find(params[:id])
    @todo_list_op = present TodoList::Show
    @todo_list = @todo_list_op.model

    @todo = form TodoList::CreateTodo
  end

  def edit
    @todo_list = form TodoList::Update
  end

  def update
    run TodoList::Update do |op|
      return redirect_to op.model, notice: "#{op.model.name} was successfully updated!"
    end

    @todo_list = form TodoList::Update
    flash[:alert] = "Name must not be blank."
    render action: :edit
  end

  def create_todo
    @todo_list_op = present TodoList::Show
    @todo_list = @todo_list_op.model

    run TodoList::CreateTodo do |op|
      return redirect_to todo_list_path(@todo_list), notice: "To-do was successfully created!"
    end

    @todo = form TodoList::CreateTodo
    flash[:alert] = "Fill up the fields"
    render :show
  end

  private

  def todo_list_params
    params.require(:todo_list).permit(:name)
  end

end
