require 'rails_helper'

RSpec.describe Todo::Create do
  context "valid" do
    context "without a todo list specified" do
      it "creates a todo to the default todo list" do
        attrs = { title: 'Create a valid todo without todo list!' }
        res, op = Todo::Create.run(todo: attrs, todo_list_id: nil)
        expect(res).to eq(true)
        expect(op.model).to be_persisted
        expect(op.model.title).to eq('Create a valid todo without todo list!')
        expect(op.model.list).to be_present
        expect(op.model.list.name).to eq('Default To-do List')
      end
    end

    context "with a todo list specified" do
      let(:todo_list) do
        attrs = { name: 'Create rspec for service seeking!' }
        TodoList::Create.(todo_list: attrs).model
      end

      it "creates a todo to the specified todo list" do
        attrs = { title: 'Create a valid todo with specified todo list!' }
        res, op = Todo::Create.run(todo: attrs, todo_list_id: todo_list.id)
        expect(res).to eq(true)
        expect(op.model).to be_persisted
        expect(op.model.title).to eq('Create a valid todo with specified todo list!')
        expect(op.model.list).to be_present
        expect(op.model.list.name).to eq('Create rspec for service seeking!')
      end
    end
  end

  context "invalid" do
    it "does not create a todo" do
      attrs = { title: nil }
      res, op = Todo::Create.run(todo: attrs)
      expect(res).to eq(false)
      expect(op.model).not_to be_persisted

      msg = op.contract.errors.full_messages
      expect(msg).to include("Title can't be blank")
    end
  end
end
