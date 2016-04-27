class TodoList::Create < Trailblazer::Operation
  include Model
  model TodoList, :create

  contract do
    property :name
    property :user_id

    validates :name, presence: true
  end

  def process(params)
    validate(params[:todo_list]) do
      contract.save
    end
  end

  def self.get_todo_list(todo_params)
    if todo_params[:todo_list_id].present?
      TodoList.find(todo_params[:todo_list_id])
    elsif TodoList.find_by_name(TodoList::DEFAULT_NAME).present?
      TodoList.find_by_name(TodoList::DEFAULT_NAME)
    else
      result, operation = TodoList::Create.run(todo_list: {})
      operation.model
    end
  end

  private

    def setup_model!(params)
      model.name = TodoList::DEFAULT_NAME unless model.name.present?
      model.user = set_user!(params)
    end

    def set_user!(params)
      return params[:current_user] if params[:current_user].present?
     
      if params[:current_user_id].nil?
        User.create!(fullname: "Guest")
      else
        User.find(params[:current_user_id])
      end
    end

end