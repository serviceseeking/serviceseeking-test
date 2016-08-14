require 'rails_helper'

RSpec.describe Todo::Create do
  it "creates a valid Todo" do
    res, todo = Todo::Create.run(todo: {title: "Title 1", description: "Desc 1"})

    expect(res).to be true
    expect(todo.model.persisted?).to be true
    expect(todo.model.title).to eq("Title 1")
    expect(todo.model.description).to eq("Desc 1")
    expect(todo.model.list.name).to eq("Default To-do List")
    expect(todo.model.list.user.fullname).to eq("Guest")
  end

	it "creates a valid Todo with a user and todo list" do
		user = User.create!(fullname: "User 2")
		todo_list = TodoList.create!(name: "List 2", user_id: user.id)
    res, todo = Todo::Create.run(todo: {title: "Title 2", description: "Desc 2"}, todo_list_id: todo_list.id)

    expect(res).to be true
    expect(todo.model.persisted?).to be true
    expect(todo.model.title).to eq("Title 2")
    expect(todo.model.description).to eq("Desc 2")
    expect(todo.model.list.name).to eq("List 2")
    expect(todo.model.list.user.fullname).to eq("User 2")
  end  

  it "does not create an invalid Todo" do
	res, todo = Todo::Create.run(todo: {title: ""})

    expect(res).to be false
    expect(todo.model.persisted?).to be false
  end
end
