class TodoList::Create < Trailblazer::Operation
  include Model
  model TodoList

  #contract do
  #  property :todo_list_id, validates:{presence:true}
  #end

  def process(params)
    #raise params.inspect
    @model = TodoList.find_or_create_by(name: "Default To-do List")
    @model.user = params[:current_user].nil? ? User.last : params[:current_user]
    @model.save
    return @model
  end
end
