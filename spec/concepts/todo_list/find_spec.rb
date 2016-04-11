require 'rails_helper'

RSpec.describe TodoList::Find do
  it "finds a todo default list" do
    todo = Todo::Create.(todo: {title: "Testing helps!"}).model
    expect(todo.list.name).to eq("Default To-do List")
  end
end
