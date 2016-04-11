require 'rails_helper'

RSpec.describe Todo::Create do
  it "can be spec'd" do
    todo = Todo::Create.(todo: {title: "Sample title"}).model
    expect(todo.title).to eq("Sample title")
  end
end
