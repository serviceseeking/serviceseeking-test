require 'rails_helper'

RSpec.describe Todo::Create, type: :operation do
  describe "Creating todo" do
    context "when title is empty" do
      it "does not create the todo item" do
        result, todo = Todo::Create.run(
          todo: { title: nil, description: ""}
        )
        expect(todo.valid?).to eq false
      end
    end

    context "when title is present" do
      it "creates a todo item" do
        todo = Todo::Create.(todo:
          { title: "Sample Task", description: "Sample Description" }
        ).model

        expect(todo.title).to eq("Sample Task")
      end
    end
  end
end
