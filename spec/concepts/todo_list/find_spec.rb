require 'rails_helper'

RSpec.describe TodoList::Find do
  it "finds a todo default list" do
    todo_list = TodoList::Find.(todo: {title: "Testing helps!"}).model
    expect(todo_list.name).to eq("Default To-do List")
  end
end
