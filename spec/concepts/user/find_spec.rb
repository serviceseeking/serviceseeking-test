require 'rails_helper'

RSpec.describe User::Find do
  it "finds a user guest" do
    todo = Todo::Create.(todo: {title: "Testing helps!"}).model
    expect(todo.list.user.fullname).to eq("Guest")
  end
end
