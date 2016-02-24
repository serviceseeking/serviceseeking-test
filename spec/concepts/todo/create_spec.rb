require 'rails_helper'

RSpec.describe Todo::Create do
  it "Should be persisted" do
    params = {todo: {title: 'Test Title'}}
    todo = Todo::Create.(params).model

    expect(todo.persisted?).to be
    expect(todo.title).to eq 'Test Title'
  end
end
