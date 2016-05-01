class TodoList::Create < Trailblazer::Operation
  include Model
  model TodoList, :create

  contract do
    property :name
    property :user_id

    validates :name, presence: true
  end

  def process(params)
    validate(params[:todo_list]) do |f|
      f.user_id = associate_user(params)
      f.save
    end
  end

  private

  def associate_user(params)
    return params[:current_user_id] if params[:current_user_id].present?
    if params[:current_user].nil?
      user_attr = { fullname: 'Guest' }
      user = User::Create.(user: user_attr).model.id
    else
      user = params[:current_user].id
    end
  end
end