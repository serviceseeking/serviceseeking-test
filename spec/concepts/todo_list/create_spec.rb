require "rails_helper"

RSpec.describe TodoList::Create, type: :operation do
  describe "Creating todo list" do

    context "when no name is given" do
      it "creates a default todo list" do
        todo_list = TodoList::Create.(todo_list:
          { id: nil, user_id: nil}
        ).model
        expect(todo_list.name).to eq("Default To-do List")
      end
    end

    context "when a name is given" do
      it "creates a new todo list with given name" do
        todo_list = TodoList::Create.(todo_list:
          { id: nil, user_id: nil, name: "Another Todo List"}
        ).model
        expect(todo_list.name).to eq("Another Todo List")
      end
    end
  end
end
