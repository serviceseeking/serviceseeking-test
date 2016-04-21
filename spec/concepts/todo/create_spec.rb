require 'rails_helper'

RSpec.describe Todo::Create do
  before(:each) do
    @todo = Todo.new()
    @user = User.new()
    @todo_list = TodoList.new()
  end

  describe Todo do
    it 'is Valid' do
      @todo.title = "Do Refactoring"
      expect(@todo.title).to eq("Do Refactoring")
      expect(@todo).to be_valid
    end

    it 'is not valid' do
      @todo.title = nil
      expect(@todo.title).to be_nil
    end
  end

  describe User  do
    it 'is Valid' do
      @user.fullname = "Guest"
      expect(@user.fullname).to eq("Guest")
      expect(@user).to be_valid
    end

    it 'is not valid' do
      @user.fullname = nil
      expect(@user.fullname).to be_nil
    end
  end

  describe TodoList do
    it 'is valid' do
      @todo_list.name = "Default To-do List"
      expect(@todo_list.name).to eq("Default To-do List")
      expect(@todo_list).to be_valid
    end

    it 'is not valid' do
      @todo_list.name = nil
      expect(@todo_list.name).to be_nil
    end
  end
end
