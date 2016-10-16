# == Schema Information
#
# Table name: todos
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  description  :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  todo_list_id :integer
#

class Todo < ActiveRecord::Base
  belongs_to :list, class_name: TodoList.name, foreign_key: 'todo_list_id'
	belongs_to :user
end
	
