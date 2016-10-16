class TodoList::Create < Trailblazer::Operation
  include Model
  include Shared::Common
  model TodoList, :create

  contract do
    property :name
    property :user_id
    validates :name, presence: true
  end

  def process(params)
    validate(params[:todo_list]) do
      if contract.user_id.blank?
        contract.user_id = current_user(params).id
      end
      contract.save
    end
    invalid!
  end
end
