class Todo::Create < Trailblazer::Operation

  include Model
  model Todo, :create

  contract do
    property :title, validates: {presence: true}
  end

  def process(params)
    validate(params[:todo]) do
      model.list = TodoList::Find.(params).model
      contract.save
    end

  end
end