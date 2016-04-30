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

  private

    def setup_model!(params)
      model.user = User::SetUser.(user: {id: params[:current_user_id]}).model
    end
end