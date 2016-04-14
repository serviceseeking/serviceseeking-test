
class Todo::Create < Trailblazer::Operation

  # Logic for creating a TODO
  #     if `todo_list` is specified
  #         create the `todo`
  #         associated with `todo_list`
  #     else
  #         create the `todo`
  #         create a `user`
  #         create a default `todo_list`
  #         associate `todo_list` with `user`
  #         associate `todo` with `todo_list`

  include Model
   model Todo, :create

  contract do
      property :title
      validates :title, presence: true
  end


  def process(params)
    if validate(params[:todo])

      # build the todo
      todo = @model = Todo.new(params.require(:todo).permit(:title, :description))

      # find or create the parent list for the todo

      todo_list = TodoList::Create.run(id: params[:todo_list_id])[1].todo_list
      
     #  if params[:todo_list_id].blank?
     #    todo_list = TodoList.find_or_create_by(name: "Default To-do List")

      

     #    #### Find or create the owner of the todo_list:
     #    #### If current_user_id is present, fetch that user
     #    #### otherwise, create a new one 

     #    current_user =
     #      if params[:current_user] == nil
     #        if params[:current_user_id] == nil
     #          User.create!(fullname: "Guest")
     #        else
     #          User.find(params[:current_user_id])
     #        end
     #      else
     #        params[:current_user]
     #      end

     #    #assign the todo_list to the user
     #  else # i.e. if params[:todo_list_id] is not nil
     #    todo_list = TodoList.find(params[:todo_list_id])
     #  end

     #  #associate the todo with the todo_list
     todo.list = todo_list
     todo.save!
    else
      return invalid!
    end
    
  end

end
