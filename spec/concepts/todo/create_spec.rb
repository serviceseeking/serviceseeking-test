require 'rails_helper'

RSpec.describe Todo::Create, type: :operation do
  it "creates todo" do
    todo = Todo::Create.(todo:
      { title: "Sample Task", description: "Sample Description" }
    ).model

    expect(todo.title).to eq("Sample Task")
  end
end
