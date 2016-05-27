require 'rails_helper'

RSpec.describe Todo::Create do

  context "when given a todo with no title" do
    todo_params = ActionController::Parameters.new(todo: {title: nil})

    it "should not create a todo item" do
      res, op = Todo::Create.run(todo_params)
      expect(op.model).not_to be_persisted
      expect(res).to be_falsey
    end
  end

  context "when given a todo with title" do
    todo_params = ActionController::Parameters.new(todo: {title: "something"})
    res, op = Todo::Create.run(todo_params)

    it "should create a valid todo item" do
      expect(res).to be true
      todo = op.model
      expect(todo).to be_persisted
      expect(todo.title).not_to be_nil
      expect(todo.todo_list_id).not_to be_nil
    end

    it "should have a valid todo list" do
      todo_list = op.model.list
      expect(todo_list).to be_persisted
      expect(todo_list.name).not_to be_nil
      expect(todo_list.user_id).not_to be_nil
    end

    it "should have a valid user" do
      user = op.model.list.user
      expect(user).to be_persisted
      expect(user.fullname).not_to be_nil
    end


  end

end
