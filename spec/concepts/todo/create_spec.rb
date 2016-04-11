require 'rails_helper'

RSpec.describe Todo::Create do
  it "can create a todo" do
    todo = Todo::Create.(todo: {title: "Testing helps!"}).model
    expect(todo.title).to eq("Testing helps!")
  end
end
