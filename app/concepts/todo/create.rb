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
    property :title, validates: { presence: true }
    property :description
    property :todo_list_id
  end

  def process(params)
    model.list = get_list(params)

    # validate and save 
    validate(params) do
      contract.save
    end
  end

  private

  def get_list(params)
    return TodoList.find(params[:todo_list_id]) if !params[:todo_list_id].blank?

    todo_list = TodoList.find_or_create_by(name: "Default To-do List")

    # assign the todo_list to the user
    todo_list.user = current_user(params)
    todo_list.save!
    return todo_list
  end

  def current_user(params)
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
  end

end
