class Todo::Create < Trailblazer::Operation
  include Model
  model Todo, :create

  contract do
    property :title, validates: {presence: true}
  end

  def process(params)
    validate(params[:todo]) do
      contract.save
    end

    model.list = TodoList::Update.(params).model
    model.save!
  end

end
