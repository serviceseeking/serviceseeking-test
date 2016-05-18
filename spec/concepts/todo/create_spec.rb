require 'rails_helper'

RSpec.describe Todo::Create do

class Todo::Create
  public :require
end

  context "when given a todo with no title" do
    todo_params = ActionController::Parameters.new(todo: {title: nil})

    it "should not create a todo item" do
      res, op = Todo::Create.run(todo_params)
      expect(op.model.id).to be_nil
      expect(res).to be_falsey
    end
  end

  context "when given a todo with title" do
    todo_params = ActionController::Parameters.new(todo: {title: "something"})
    res, op = Todo::Create.run(todo_params)

    it "should create a valid todo item" do
      expect(op.model.id).not_to be_nil
      expect(op.model.todo_list_id).not_to be_nil
      expect(res).to be true
    end

  end

end
