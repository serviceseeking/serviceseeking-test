require 'rails_helper'

RSpec.describe Todo::Create do

  let!(:user) { User.create fullname: "Exiting User" }
  let!(:todo_list) {  TodoList.create! name: "Testing List", user_id: user.id }

  it "should create a todo and assign it to a existing list" do
    @todo = Todo::Create.({ title: 'todo title',
                            description: 'todo description',
                            todo_list_id: todo_list.id}).model

    expect(@todo.todo_list_id).equal? todo_list.id
  end

  it "should create a todo and assign it to a existing list" do
    @todo = Todo::Create.({ title: 'todo title',
                            description: 'todo description'}).model
    expect(@todo.todo_list_id).equal? todo_list.id
  end

end
