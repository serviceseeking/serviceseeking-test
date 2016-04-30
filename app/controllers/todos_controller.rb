class TodosController < ApplicationController

  def new
    form Todo::Create
  end

  def create
    run Todo::Create do
      return redirect_to @model.list, notice: "To-do was successfully created!"
    end

    render :new
  end

end
