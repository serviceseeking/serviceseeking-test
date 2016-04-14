require 'rails_helper'

RSpec.describe Todo::Create, type: :operation do
  it "can be spec'd" do
    puts "Implement me"
  end

  it "Todo Created" do
    todo = Todo::Create.(todo: {title: "Operation rules!", description: "Operation rules!"}).model
    expect(todo.title).to eq("Operation rules!")
    expect(todo.description).to eq("Operation rules!")
  end

  it "Associated Todo List" do
    todo_list = TodoList.find_or_create_by(name: "Default To-do List")
    todo = Todo::Create.(todo: {title: "Operation rules!", description: "Operation rules!"}, todo_list_id: todo_list.id).model
    todo.should_not be_nil
  end

end
