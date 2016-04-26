require 'rails_helper'

describe TodoList do
  before(:each) do
    @password_hldr = "12345!Aa"
    @user = Session::Create.({user: {username: 'TestUser', password: @password_hldr, confirm_password: @password_hldr,
                                     fullname: 'Test User'}}).model
  end

  describe TodoList::Create do
    it 'should fail creating a list without a valid user' do
      expect{TodoList::Create.({todo_list: { name: 'this is a test'}})}.to raise_error(Trailblazer::Operation::InvalidContract)
    end

    it 'should fail to create a list without a valid name' do
      expect{TodoList::Create.({todo_list: {user_id: @user.id}})}.to raise_error(Trailblazer::Operation::InvalidContract)
    end

    it 'should create a list with a valid user' do
      expect{TodoList::Create.({todo_list: {name: 'this is a test', user_id: @user.id}})}.to change(TodoList, :count).by(1)
    end
  end

  describe TodoList::Delete do
    it 'should delete a record from database' do
      list = TodoList::Create.({ todo_list: {name: 'Todo test list', user_id: @user.id}}).model
      expect{TodoList::Delete.({id: list.id})}.to change(TodoList, :count).by(-1)
    end
  end

  describe TodoList::GetOrCreateDefaultTodoList do
    it "should create a default list" do
      expect{TodoList::GetOrCreateDefaultTodoList.({user_id: @user.id})}.to change(TodoList, :count).by(1)
    end

    it "should not create a new default list" do
      list = TodoList::Create.({ todo_list: {name: 'Todo test list', user_id: @user.id}}).model
      expect{TodoList::GetOrCreateDefaultTodoList.({user_id: @user.id})}.to change(TodoList, :count).by(0)
    end
  end
end
