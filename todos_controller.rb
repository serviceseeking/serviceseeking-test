class TodosController < ApplicationController

  def new
  	params[:todo_list_id].nil? ? "" : @todo_list = TodoList.find(params[:todo_list_id])
  	@todo = form Todo::Create
  end

  def create
  	run Todo::Create do |op|
      return redirect_to todo_list_path(op.model.list.id), notice: "To-do was successfully created!"
    end

    @todo = form Todo::Create
    flash[:alert] = "Fill up the fields"
    render action: :new
  end

end
