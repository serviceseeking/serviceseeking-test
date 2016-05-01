require 'rails_helper'

RSpec.describe TodoList::Create do
  context "valid" do
    context "without a current_user or current_user_id specified" do
      it "creates a todo list to the guest user" do
        attrs = { name: 'Valid todo list for guest user!' }
        res, op = TodoList::Create.run(todo_list: attrs, current_user: nil, current_user_id: nil)
        expect(res).to eq(true)
        expect(op.model).to be_persisted
        expect(op.model.name).to eq('Valid todo list for guest user!')
        expect(op.model.user).to be_present
        expect(op.model.user.fullname).to eq('Guest')
      end
    end

    context "with a current_user object or id specified" do
      let(:user) do
        attrs = { fullname: 'Jeffrey Castro' }
        User::Create.(user: attrs).model
      end

      it "creates a todo list to the user object specified" do
        attrs = { name: 'Valid todo list for current user!' }
        res, op = TodoList::Create.run(todo_list: attrs, current_user: user, current_user_id: nil)
        expect(res).to eq(true)
        expect(op.model).to be_persisted
        expect(op.model.name).to eq('Valid todo list for current user!')
        expect(op.model.user).to be_present
        expect(op.model.user.fullname).to eq('Jeffrey Castro')
      end

      it "creates a todo list to the user id specified" do
        attrs = { name: 'Valid todo list for current user!' }
        res, op = TodoList::Create.run(todo_list: attrs, current_user: nil, current_user_id: user.id)
        expect(res).to eq(true)
        expect(op.model).to be_persisted
        expect(op.model.name).to eq('Valid todo list for current user!')
        expect(op.model.user).to be_present
        expect(op.model.user.fullname).to eq('Jeffrey Castro')
      end
    end
  end

  context "invalid" do
    it "does not create a todo list" do
      attrs = { name: nil }
      res, op = TodoList::Create.run(todo_list: attrs)
      expect(res).to eq(false)
      expect(op.model).not_to be_persisted

      msg = op.contract.errors.full_messages
      expect(msg).to include("Name can't be blank")
    end
  end
end
