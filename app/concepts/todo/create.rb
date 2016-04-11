class Todo::Create < Trailblazer::Operation
  include Model
  model Todo, :create

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

  contract do
    property :title, validates: {presence: true}
  end

  def process(params)
    # make sure title is not blank
    # build the todo
    validate(params[:todo]) do
      contract.save
    end

    # find or create the parent list for the todo
    #if params[:todo_list_id].blank?
      #todo_list = TodoList.find_or_create_by(name: "Default To-do List")

      # Find or create the owner of the todo_list:
      ##### If current_user_id is present, fetch that user
      ##### otherwise, create a new one
      #current_user =
        #if params[:current_user] == nil
          #if params[:current_user_id] == nil
            #User.create!(fullname: "Guest")
          #else
            #User.find(params[:current_user_id])
          #end
        #else
          #params[:current_user]
        #end

      # assign the todo_list to the user
      #todo_list.user = current_user
      #todo_list.save!
    #else # i.e. if params[:todo_list_id] is not nil
      #todo_list = TodoList.find(params[:todo_list_id])
    #end

    # associate the todo with the todo_list
    #model.list = todo_list
    #model.save!

    model.list = TodoList::Create.(params).model
    model.save!
  end

end
