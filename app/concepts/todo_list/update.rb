class TodoList::Update < Trailblazer::Operation

  def process(params)
    if params[:todo_list_id].blank?
      @model =  TodoList.find_or_create_by(name: "Default To-do List")
      @model.user =  User::Create.(params).model
      @model.save!
    else
      @model = TodoList.find(params[:todo_list_id])
    end
  end
end
