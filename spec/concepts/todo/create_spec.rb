require 'rails_helper'

RSpec.describe Todo::Create do

  describe "#process" do
    subject { described_class }

    let(:default_params) do
      { todo: todo_params }
    end
    let(:todo_params) do
      { title: 'Sample Todo Title' }
    end

    describe "title states" do
      context "when present" do
        it "saves successfully" do
          result = subject.run(default_params)
          todo = result.last.model

          expect(todo.title).to eq("Sample Todo Title")
        end
      end

      context "when empty string" do
        let(:todo_params) do
          { title: '' }
        end

        it "does not create anything" do
          subject.run(default_params)

          expect(Todo.count).to be 0
        end
      end
    end

    describe "todo_list_id states" do
      context "when present" do
        let!(:todo_list) do
          TodoList.create({
            id: 1,
            name: "Sample TodoList",
          })
        end
        let(:params) { default_params.merge(todo_list_id: 1) }

        it "finds the corresponding TodoList" do
          result = subject.run(params)
          todo = result.last.model

          expect(todo.list.name).to eq("Sample TodoList")
        end
      end

      context "when blank" do
        it "finds or create a default todo list" do
          subject.run(default_params)

          expect(TodoList.last.name).to eq("Default To-do List")
        end
      end
    end

    describe "current_user_id states" do
      context "when present" do
        let!(:user) do
          User.create({
            id: 5,
            fullname: 'Sample User',
          })
        end
        let(:params) { default_params.merge(current_user_id: 5) }

        it "finds the corresponding User" do
          result = subject.run(params)
          todo = result.last.model
          user = todo.list.user

          expect(user.fullname).to eq("Sample User")
        end
      end

      context "when blank" do
        it "finds or create a guest user" do
          subject.run(default_params)

          expect(User.last.fullname).to eq("Guest")
        end
      end
    end
  end

end
