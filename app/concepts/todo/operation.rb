class Todo::Create < Trailblazer::Operation
  include Model
  model Todo, :create

  contract do
    property :title, validates: { presence: true }
    property :description
    property :todo_list_id
    property :completed
  end

  def process(params)
    # validate and save
    validate(params[:todo]) do
      contract.save
    end
  end

end

class Todo::Update < Trailblazer::Operation
  include Model
  model Todo, :update

  contract do
    property :title, validates: { presence: true }
    property :description
    property :completed
  end

  def process(params)
    # validate and save
    validate(params[:todo]) do
      contract.save
    end
  end

end


class Todo::Delete < Trailblazer::Operation
  include Model
  model Todo, :find

  def process(params)
    validate(params) do
      model.delete
    end
  end
end
