class User < ActiveRecord::Base
  has_many :todo_lists
  DEFAULT_FULLNAME = "Guest"
end
