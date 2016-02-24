class TodosController < ApplicationController

  def new
  	form Todo::Create
  end

  def create
    run Todo::Create do |op|
      return redirect_to op.model.list, notice: "To-do was successfully created!"
    end

    redirect_to root_path, alert: "To-do can't be blank"
  end

  def edit
  	form Todo::Update
  end

  def update
  	run Todo::Update do |op|
  		return redirect_to op.model.list, notice: "To-do was successfully updated!"
  	end

  	redirect_to todo_list_path(@model.list), alert: "To-do can't be blank"
  end

  def destroy
  	todo = Todo.find(params[:id])
  	todo.destroy
  	redirect_to todo_list_path(todo.list), notice: "To-do was successfully deleted!"
  end
end