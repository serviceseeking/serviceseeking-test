class TodosController < ApplicationController
  def new
  end

  def create
    res = run Todo::Create do
      return redirect_to @model.list, notice: "To-do was successfully created!"
    end

    @errors = res.errors.full_messages
    render :new
  end
end
