class TodoList::Create < Trailblazer::Operation
  include Model
  model TodoList, :create

  contract do   
    property :id
    validates :id, presence: true
  end
  attr_accessor :todo_list
  def process(params)
    if validate(params)
      @todo_list = TodoList.find(params[:id])
    else
      @todo_list = TodoList.find_or_create_by(name: "Default To-do List")
      current_user = 
        if params[:current_user] == nil 
          User::Create.run(id: params[:current_user_id])[1].user
        else
          params[:current_user]
        end
      @todo_list.user = current_user
      @todo_list.save!
    end
    

  end

end