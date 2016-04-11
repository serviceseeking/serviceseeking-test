class TodoList::Find < Trailblazer::Operation

  def process(params)
      model.user = params[:current_user] == nil ? User::Find.(params).model : params[:current_user]
      model.save!
  end

  def model!(params)
    if params[:todo_list_id].blank?
      TodoList.find_or_create_by(name: "Default To-do List")
    end
  end

end