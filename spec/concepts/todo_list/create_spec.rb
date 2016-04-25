require 'rails_helper'

RSpec.describe TodoList::Create do
  let(:user) do
    User.create( username: 'test_user',
        fullname: 'test user',
        password_hash: 'test',
        password_salt: 'test')
  end

  describe 'validations' do
    it 'validates the presence of name' do
      result, operation = TodoList::Create.run(todo_list: { name: nil,
                                                  user_id: user.id })

      expect(result).to eq false
      expect(operation.errors.full_messages).to include "Name can't be blank"
    end
  end

  describe '#process' do
    it 'creates a to-do list for an existing user' do
      todo_list = TodoList::Create.(todo_list: { name: 'test name',
                                      user_id: user.id }).model

      expect(todo_list).to be_persisted
      expect(todo_list.name).to eq('test name')
      expect(todo_list.user).to eq(user)
    end

    it 'creates a to-do list for a guest user' do
      todo_list = TodoList::Create.(todo_list: { name: 'test name' }).model

      expect(todo_list).to be_persisted
      expect(todo_list.name).to eq('test name')
      expect(todo_list.user.fullname).to eq('Guest')
    end
  end
end
