class User < ActiveRecord::Base
  has_many :todo_lists
  #has_many :todo

  serialize :auth_meta_data
end
