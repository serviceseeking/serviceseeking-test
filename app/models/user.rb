class User < ActiveRecord::Base
  has_many :todo_lists

  def self.check_users(params)
    params[:current_user_id].nil? ? self.create!(fullname: "Guest") : self.find(params[:current_user_id])
  end

end
