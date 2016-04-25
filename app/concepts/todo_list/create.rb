class TodoList::Create < Trailblazer::Operation
  include Model
  model TodoList, :create

  contract do
    property :user
  end

  def process(params)
    @model = params[:todo_list_id].nil? ? TodoList.find_or_create_by(name: "Default To-do List") : TodoList.find(params[:todo_list_id])
    validate(params, @model) do |f|
      f.user = check_users(params)
      f.save
    end
  end

  private

  def check_users(params)
    params[:todo][:fullname].blank? ? User::Create.(params).model : User::Check.(params).model
  end

end
