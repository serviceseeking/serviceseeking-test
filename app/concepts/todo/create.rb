class Todo::Create < Trailblazer::Operation
  include Model
  model Todo, :create
  
  contract do
    property :title, validates: {presence: true}
    property :list
    property :description
  end

  def process(params)
    validate(params[:todo], @model) do |f|
      f.list = find_lists(params)
      f.save
    end
  end

  private

  def find_lists(params)
    TodoList::Create.(params).model
  end

end
