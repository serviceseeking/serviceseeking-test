require 'rails_helper'

RSpec.describe Todo::Create do
  let(:user) do
    User.create( username: 'test_user',
        fullname: 'test user',
        password_hash: 'test',
        password_salt: 'test')
  end

  let(:user_todo_list) do
    TodoList.create( user_id: user.id,
        name: 'test to do list')
  end

  let(:todo_list) do
    TodoList.create(user_id: nil,
        name: 'test to do list')
  end

  describe 'validations' do
    it 'validates the presence of a title' do
      result, operation = Todo::Create.run(todo: { title: nil,
                                                  todo_list_id: todo_list.id })

      expect(result).to eq false
      expect(operation.errors.full_messages).to include "Title can't be blank"
    end
  end

  describe '#process' do
    it 'creates a todo without an existing to-do list' do
      todo = Todo::Create.(todo: { title: 'test title',
                                      description: 'test description'}).model
      default_todo_list = TodoList.find_by_name("Default To-do List")

      expect(todo).to be_persisted
      expect(todo.title).to eq('test title')
      expect(todo.description).to eq('test description')
      expect(todo.list).to eq(default_todo_list)
    end

    it 'creates a todo from an existing to-do list of an existing user' do
      todo = Todo::Create.(todo: { title: 'test title',
                                      description: 'test description',
                                      todo_list_id: user_todo_list.id }).model

      expect(todo).to be_persisted
      expect(todo.title).to eq('test title')
      expect(todo.description).to eq('test description')
      expect(todo.list).to eq(user_todo_list)
    end

    it 'creates a todo from an existing to-do list of a guest user' do
      todo = Todo::Create.(todo: { title: 'test title',
                                      description: 'test description',
                                      todo_list_id: todo_list.id }).model
      default_user = User.find_by_fullname("Guest")

      expect(todo).to be_persisted
      expect(todo.title).to eq('test title')
      expect(todo.description).to eq('test description')
      expect(todo.list).to eq(todo_list)
    end
  end
end
