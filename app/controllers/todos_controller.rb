class TodosController < ApplicationController

  def new
  end

  def create
    run Todo::Create do
      return redirect_to @model.list, notice: "To-do was successfully created!"
    end

    flash.now[:alert] = "Missing todo title"
    render :new
  end

end
