class TodoList < ActiveRecord::Base
  belongs_to :user
  has_many :todos, dependent: :destroy

  def self.check_list(params)
    todo_list = self.find_or_create_by(name: "Default To-do List")
    todo_list.user = params[:current_user].nil? ? User.check_users(params) : params[:current_user]
    todo_list.save
    return todo_list
  end
end
