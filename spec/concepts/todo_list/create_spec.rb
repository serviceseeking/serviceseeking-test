require 'rails_helper'

RSpec.describe TodoList::Create do
  it "successfully creates a todoList" do
    expect{
      TodoList::Create.(todo_list: {name: "Test"})
    }.to change{TodoList.count}.by(1)
  end
end

