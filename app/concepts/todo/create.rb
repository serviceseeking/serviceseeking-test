class Todo::Create < Trailblazer::Operation
  include Model
  model Todo, :create

  contract do
    property :title
    property :todo_list_id

    validates :title, presence: true
  end

  def process(params)
    validate(params[:todo]) do |f|
      f.save
      
      associate_todo_list! if f.model.list.nil?
    end
  end

  def associate_todo_list!
    todo_list = TodoList.find_or_create_by(name: "Default To-do List")
    @model.list = todo_list
    @model.save!
  end
end
