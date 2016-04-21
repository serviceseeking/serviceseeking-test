class Todo::Create < Trailblazer::Operation

  #builds do |params|
    #return Todo if !params[:todo][:title].blank?
  #end

  contract do
    #validates :title, presence: true
    #property :title, validates: {presence: true}
  end

  def process(params)
    # make sure title is not blank
    validates(params[:todo][:title]) do
      railse "test".inspect
    end
    return invalid! if params[:todo][:title].blank?

    # build the todo
    todo = @model = Todo.new(params.require(:todo).permit(:title, :description))

    # find or create the parent list for the todo
    todo_list = params[:todo_list_id].blank? ? check_default(params) : TodoList.find(params[:todo_list_id])

    # associate the todo with the todo_list
    todo.list = todo_list
    todo.save!
  end

  def check_default(params)
    todo_list = TodoList.find_or_create_by(name: "Default To-do List")
    todo_list.user = params[:current_user].nil? ? check_users(params) : params[:current_user]
    todo_list.save
    return todo_list
  end
  
  def check_users(params)
    params[:current_user_id].nil? ? User.create!(fullname: "Guest") : User.find(params[:current_user_id])
  end

end
