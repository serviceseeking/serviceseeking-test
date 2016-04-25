require 'rails_helper'

RSpec.describe TodoList::Create do
  before do
    @user = User.create(fullname: "Guest")
  end

  it "should create todo list" do
    @todo_list = TodoList.create!(name: "Default To-do List", user: @user)
    expect(@todo_list.user).equal? @user
  end



end
