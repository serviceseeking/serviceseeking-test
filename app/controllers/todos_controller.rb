class TodosController < ApplicationController

  def new
  end

  def create
    todo = run Todo::Create
    if todo.errors.any?
      flash.now[:alert] = todo.errors.full_messages.join(",")
      render :new
    else
      return redirect_to todo.model.list, notice: "To-do was successfully created!"
    end
  end

end
