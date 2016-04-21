class Todo::Create < Trailblazer::Operation
  # i put this because when we enter a nil or blank title form i got error undefine title
  include Model
  model Todo
  #builds do |params|
    #return invalid! if params[:todo][:title].blank?
  #end

  contract do
    property :title, validates: {presence: true}
    #validates :title, presence: true
  end

  def process(params)
    # make sure title is not blank
    
    @model = Todo.new(params.require(:todo).permit(:title, :description))
    
    validate(params[:todo], @model) do |f|
      todo_list = params[:todo_list_id].blank? ? check_default(params) : TodoList.find(params[:todo_list_id])
      @model.title = f.title
      @model.list = todo_list
      @model.save
      #f.save
    end
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
