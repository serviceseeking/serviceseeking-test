class Todo::Create < Trailblazer::Operation
  include Model
  model Todo, :create

  contract do
    property :title, validates: {presence: true}
  end

  def process(params)
    begin
      validate(params[:todo]) do |f|
        @model = Todo.new(ActiveSupport::HashWithIndifferentAccess.new(params[:todo]))
        if params[:todo_list_id].blank?
          todo_list = TodoList.find_or_create_by(name: "Default To-do List")
          current_user =

            if params[:current_user] == nil
              if params[:current_user_id] == nil
                User.create!(fullname: "Guest")
              else
                User.find(params[:current_user_id])
              end
            else
              params[:current_user]
            end

          todo_list.user = current_user
          todo_list.save!
        else
          todo_list = TodoList.find(params[:todo_list_id])
        end

        @model.list = todo_list
        @model.save!
      end
    rescue Exception => e
      puts e.inspect
    end
  end

end
