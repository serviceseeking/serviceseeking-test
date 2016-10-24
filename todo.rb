class Todo < ActiveRecord::Base
  belongs_to :list, class_name: TodoList.name, foreign_key: 'todo_list_id'
  #belongs_to :user
end
	
