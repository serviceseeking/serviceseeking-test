# == Schema Information
#
# Table name: todo_lists
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TodoList < ActiveRecord::Base
  belongs_to :user
  has_many :todos, dependent: :destroy
end
