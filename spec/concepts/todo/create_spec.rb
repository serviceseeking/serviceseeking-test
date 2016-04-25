require 'rails_helper'

RSpec.describe Todo::Create do
   let!(:user) { User.create fullname: "Guest" }
   let!(:todo_list) { TodoList.create!(name: "Refactor List", user_id: user.id)}

   it "create todo and assign the existing list" do
      @todo = Todo::Create.(todo: {title: "Todo Refactor", description: "Todo Description", list: todo_list}).model
      expect(@todo.todo_list_id).equal? todo_list.id
   end

   it "should create a todo and assign it to a existing list" do
      @todo = Todo::Create.(todo: { title: 'todo title', description: 'todo description'}).model
    	
      expect(@todo.todo_list_id).equal? todo_list.id
   end

   
end
