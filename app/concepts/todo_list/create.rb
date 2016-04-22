class TodoList::Create < Trailblazer::Operation
  include Model
  model TodoList

  def process(params)
    todo_list = @model = TodoList.find_or_create_by(name: "Default To-do List")
    todo_list.user = params[:todo][:fullname].blank? ? User::Create.(params).model : User::Check.(params).model#params[:current_user]
    todo_list.save
  end
end
