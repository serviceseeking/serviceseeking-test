class TodoList::Policy 
  def initialize(user_id, todo_list)
    @user_id = user_id
    @todo_list = todo_list
  end

  def find?
    @user_id == @todo_list.id
  end
end
