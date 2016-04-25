class Todo::Create < Trailblazer::Operation
  include Model
  model Todo, :create

  contract do
    property :title
    property :description
    property :todo_list_id

    validates :title, presence: true
  end

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
  def process(params)
    # please try to debugger the output of validate(params[:todo]) here
    # it should be false if there is validation error, true otherwise
    validate(params[:todo]) do
      contract.save
    end
  end

  private

    def setup_model!(todo_params)
      # find or create the parent list for the todo
      if todo_params[:todo_list_id].present?# i.e. if params[:todo_list_id] is not nil
        todo_list = TodoList.find(todo_params[:todo_list_id])
      elsif TodoList.find_by_name("Default To-do List").present?
        todo_list = TodoList.find_by_name("Default To-do List")
      else
        result, operation = TodoList::Create.run(todo_list: { name: "Default To-do List" })
        todo_list = operation.model
      end
      model.list = todo_list
    end
end