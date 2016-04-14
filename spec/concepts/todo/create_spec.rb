require 'rails_helper'

RSpec.describe Todo::Create do
  # it "can be spec'd" do
  #   raise "Implement me"
  # end
  subject { Todo.new }

  it 'makes sure todo has a title' do
  	expect(subject.save).to be(false)
  end

  it 'creates a todo' do
  	todo = Todo.new(title: 'get milk', description: 'get it at robinsons supermarket and not at 711')
  	expect(todo.save).to be(true)
  end

  it 'attaches todo to the default to-do list if it is unassigned to any to-do list' do
  	todo = Todo.new(title: 'get water', description: 'at savemore')
  	todo.save

  	if todo.list.name.blank?
	  	todo_list = TodoList.find_or_create_by(name: "Default To-do List")
			todo.todo_list.name = todo_list
		end
  	expect(todo.list.name).to eq("Default To-do List")
  end

  it 'creates user if todo_list is not assigned for a user' do
		expect(subject.list.user).to be("Guest")  
	end



end
