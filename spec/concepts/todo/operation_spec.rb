require 'rails_helper'

RSpec.describe Todo do
  before(:each) do
    @password_hldr = "12345!Aa"
    @user = Session::Create.({user: {username: 'TestUser', password: @password_hldr, confirm_password: @password_hldr,
                                     fullname: 'Test User'}}).model

    @todo_list = TodoList::Create.({ todo_list: { name: "Testing List", user_id: @user.id }}).model
    @todo = Todo::Create.({ todo: { title: 'A new todo', description: 'None Provided'}}).model
  end

  describe Todo::Create do
    it "should create a todo and assign it to a existing list" do
      expect(@todo.todo_list_id).equal? @todo_list.id
    end

    it "should create a todo and assign it to a new list" do
      @new_todo = Todo::Create.({ todo: { title: 'todo title',
                                      description: 'todo description'}}).model
      expect(@new_todo.todo_list_id).equal? @todo_list.id
    end
  end

  describe Todo::Delete do
 
    it "should should delete the todo" do
      expect{Todo::Delete.({id: @todo.id })}.to change(Todo, :count).by(-1)
    end
  end

end
