class TodoList::Create < Trailblazer::Operation
  include Model
  model TodoList, :create

  contract do
    property :id
    property :name
    property :user_id
  end

  def process(params)
    validate(params[:todo_list]) do |f|
      @model = TodoList.find_by_id(f.id) ||
        TodoList.find_or_create_by(name: "Default To-do List")
      @model.user = find_or_create_user(params)
    end
  end

  def find_or_create_user(params)
    User::Create.(user_params(params)).model
  end

  def user_params(params)
    {
      user: {
        id: params[:todo_list][:user_id],
      },
    }
  end

end
