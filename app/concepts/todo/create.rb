class Todo::Create < Trailblazer::Operation
  include Model
  model Todo, :create

  contract do
    property :title, validates: { presence: true }
    property :list
  end

  def process(params)
    validate(params[:todo]) do |todo_item|

      if params[:todo_list_id].present?
        todo_list = TodoList.find(params[:todo_list_id])
      else
        if params[:current_user].present?
          user = User.find(params[:current_user_id])
        else
          user = User.create(fullname: "Guest")
        end

        todo_list = TodoList.find_or_create_by(name: "Default To-do List")
        todo_list.user = user
        todo_list.save
      end

      todo_item.list = todo_list
      todo_item.save
    end
  end

end
