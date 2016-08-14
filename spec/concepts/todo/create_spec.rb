require 'rails_helper'

RSpec.describe Todo::Create do
  it "creates a valid Todo" do
    res, todo = Todo::Create.run(todo: {title: "Title 1", description: "Desc 1"})

    expect(res).to be true
    expect(todo.model.persisted?).to be true
    expect(todo.model.title).to eq("Title 1")
    expect(todo.model.description).to eq("Desc 1")
    expect(todo.model.list.name).to eq("Default To-do List")
  end

  it "does not create an invalid Todo" do
	res, todo = Todo::Create.run(todo: {title: ""})

    expect(res).to be false
    expect(todo.model.persisted?).to be false
  end
end
