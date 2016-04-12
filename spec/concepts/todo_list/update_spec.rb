require 'rails_helper'

RSpec.describe TodoList::Update do
	#context "when a todo list is not found" do
  	it "creates a new todo list" do
    	todo_list = TodoList::Update.(todo: {title: "Sample title"}).model
    	expect(todo_list.name).to eq("Default To-do List")
  	end
  #end
end