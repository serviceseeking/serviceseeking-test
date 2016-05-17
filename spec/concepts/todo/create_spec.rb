require 'rails_helper'

RSpec.describe Todo::Create do

class Todo::Create
  public :require
end

  context "when given a todo with no title" do
    todo_params = ActionController::Parameters.new(todo: {title: nil})
    op = Todo::Create.(todo_params)
    it "should not create a todo item" do
      expect(op.model.id).to be_nil
    end
  end

  context "when given a todo with title" do
    todo_params = ActionController::Parameters.new(todo: {title: "something"})
    op = Todo::Create.(todo_params)

    it "should create a todo item" do
      expect(op.model.id).not_to be_nil
    end

    it "should belong to a todo list" do
      expect(op.model.todo_list_id).not_to be_nil
    end

  end

end
