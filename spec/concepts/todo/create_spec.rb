require 'rails_helper'

RSpec.describe Todo::Create do
  it "successfully creates a todo" do
    expect{
      Todo::Create.(todo: {title: "Test"})
    }.to change{Todo.count}.by(1)
  end
end
