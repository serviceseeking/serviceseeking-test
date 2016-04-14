class Todo < ActiveRecord::Base
	validates :title, presence: true
  belongs_to :list, class_name: TodoList.name, foreign_key: 'todo_list_id'
	belongs_to :user
end
	
