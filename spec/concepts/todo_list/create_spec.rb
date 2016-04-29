require "rails_helper"

RSpec.describe TodoList::Create, type: :operation do
  it "creates a default todo list" do
    todo_list = TodoList::Create.(todo_list:
      { id: nil, user_id: nil}
    ).model

    expect(todo_list.name).to eq("Default To-do List")
  end
end
