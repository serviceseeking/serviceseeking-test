require 'rails_helper'

RSpec.describe TodoList::Create do
  it "creates a valid Todo List for the given current user id" do
    current_user = User::Create.(user: { fullname: "Bruce Wayne" }).model
    res, todo_list = TodoList::Create.run(todo_list: { name: "List 1" }, current_user_id: current_user.id)

    expect(res).to be true
    expect(todo_list.model.persisted?).to be true
    expect(todo_list.model.name).to eq("List 1")
    expect(todo_list.model.user.fullname).to eq("Bruce Wayne")
  end

	it "creates a valid Todo List for the given current user" do
		current_user = User::Create.(user: { fullname: "Selena Kyle" }).model
    res, todo_list = TodoList::Create.run(todo_list: { name: "List 2" }, current_user: current_user)

    expect(res).to be true
    expect(todo_list.model.persisted?).to be true
    expect(todo_list.model.name).to eq("List 2")
    expect(todo_list.model.user.fullname).to eq("Selena Kyle")
  end

  it "creates a valid Todo List for the Guest user" do
    res, todo_list = TodoList::Create.run(todo_list: { name: "List 3" })

    expect(res).to be true
    expect(todo_list.model.persisted?).to be true
    expect(todo_list.model.name).to eq("List 3")
    expect(todo_list.model.user.fullname).to eq("Guest")
  end   

  it "does not create an invalid Todo List" do
  	res, todo_list = TodoList::Create.run(todo_list: { name: "" })

    expect(res).to be false
    expect(todo_list.model.persisted?).to be false
    error_msg = todo_list.contract.errors.full_messages
    expect(error_msg).to include("Name can't be blank")
  end
end
