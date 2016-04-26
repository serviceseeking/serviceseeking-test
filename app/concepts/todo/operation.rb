class Todo::BaseClass < Trailblazer::Operation
  include Model
  model Todo

  contract do
    property :title, validates: { presence: true }
    property :description
    property :todo_list_id
    property :completed
  end

  def process(params)
    validate(params[:todo]) do
      contract.save
    end
  end
end

class Todo::Create <  Todo::BaseClass
  action :create
end

class Todo::Update < Todo::BaseClass
  action :update
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
