require 'rails_helper'

RSpec.describe Todo::Create do
  it "creates a valid Todo on the given list" do
    todo_list = TodoList::Create.(todo_list: { name: "New List" }).model
    res, todo = Todo::Create.run(todo: { title: "Title 1", description: "Desc 1" }, todo_list_id: todo_list.id)

    expect(res).to be true
    expect(todo.model.persisted?).to be true
    expect(todo.model.title).to eq("Title 1")
    expect(todo.model.description).to eq("Desc 1")
    expect(todo.model.list.name).to eq("New List")
  end

	it "creates a valid Todo on the default list" do
    res, todo = Todo::Create.run(todo: { title: "Title 2", description: "Desc 2" })

    expect(res).to be true
    expect(todo.model.persisted?).to be true
    expect(todo.model.title).to eq("Title 2")
    expect(todo.model.description).to eq("Desc 2")
    expect(todo.model.list.name).to eq("Default To-do List")
  end  

  it "does not create an invalid Todo" do
  	res, todo = Todo::Create.run(todo: { title: "" })

    expect(res).to be false
    expect(todo.model.persisted?).to be false
    error_msg = todo.contract.errors.full_messages
    expect(error_msg).to include("Title can't be blank")
  end
end
