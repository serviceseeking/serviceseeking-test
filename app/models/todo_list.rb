class TodoList < ActiveRecord::Base
  belongs_to :user
  has_many :todos, dependent: :destroy

  DEFAULT_NAME = "Default To-do List"
end
