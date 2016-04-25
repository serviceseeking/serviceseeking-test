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
      model.user = set_user!(params)
    end

    def set_user!(params)
      ##### If current_user_id is present, fetch that user
      ##### otherwise, create a new one
      return params[:current_user] if params[:current_user].present?
     
      if params[:current_user_id].nil?
        User.create!(fullname: "Guest")
      else
        User.find(params[:current_user_id])
      end
    end

end