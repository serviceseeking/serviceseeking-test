class Todo::Create < Trailblazer::Operation
  include Model
  model Todo, :create

  contract do
    property :title
    property :description
    property :todo_list_id

    validates :title, presence: true
  end

  def process(params)
    validate(params[:todo]) do
      contract.save
    end
  end

  private

    def setup_model!(todo_params)
      model.list = TodoList::SetList.(todo_list: {id: todo_params[:todo_list_id]}).model
    end
end