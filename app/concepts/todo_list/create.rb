class TodoList::Create < Trailblazer::Operation
  include Model
  model TodoList, :create

  def process(params)
    # find or create the parent list for the todo
    if params[:todo_list_id].blank?
      model =  TodoList.find_or_create_by(name: "Default To-do List")

      # Find or create the owner of the todo_list:
      ##### If current_user_id is present, fetch that user
      ##### otherwise, create a new one
      current_user =
        if params[:current_user] == nil
          if params[:current_user_id] == nil
            User.create!(fullname: "Guest")
          else
            User.find(params[:current_user_id])
          end
        else
          params[:current_user]
        end

      # assign the todo_list to the user
        model.user = current_user
        model.save!
    else
      model = TodoList.find(params[:todo_list_id])
    end
  end
end
