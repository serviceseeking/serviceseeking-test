require 'rails_helper'

RSpec.describe TodoList::Create do
	it "valid" do
		res, op = TodoList::Create.run(todo_list: {name: "Sample Todo List"})

		expect(res).to be true
	end
	it "invalid" do
		res, op = TodoList::Create.run(todo_list: {name: ""})

		expect(res).to be false
		expect(op.contract.errors.to_s).to eq "{:name=>[\"can't be blank\"]}"
	end
end
