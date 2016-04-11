class TodoList::Find < Trailblazer::Operation

  def process(params)
      model.user = params[:current_user] == nil ? User::Find.(params).model : params[:current_user]
  end

  def model!(params)
    if params[:todo_list_id].blank?
      TodoList.find_or_create_by(name: "Default To-do List")
    else
      TodoList.find(params[:todo_list_id])
    end
  end

end