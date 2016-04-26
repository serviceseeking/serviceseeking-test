class TodoList::Create < Trailblazer::Operation
  include Model
  model TodoList, :create

  contract do
    property :name
    property :user_id

    validates :name, presence: true
    validates :user_id, presence: true
    validate :user_exists?

    def user_exists?
      # return true if self.user_id.nil?
      return if User.where(id: self.user_id).exists?

      self.errors.add(:user_id, 'does not exist')
      false
    end
  end

  def process(params)
    validate(params[:todo_list]) do
      contract.save
    end
  end
end

class TodoList::Update < Trailblazer::Operation
  include Model
  model TodoList, :update

  contract do
    property :name
    property :user_id

    validates :name, presence: true
    validates :user_id, presence: true
    validate :user_exists?

    def user_exists?
      return true if self.user_id.nil?
      return true if User.where(id: self.user_id).exists?

      self.errors.add(:user_id, 'User id does not exist')
      false
    end
  end

  def process(params)
    validate(params[:todo_list]) do
      contract.save
    end
  end
end

class TodoList::Find < Trailblazer::Operation
  include Model
  model TodoList, :find

  def process(params)
  end
end

class TodoList::Delete < Trailblazer::Operation
  include Model
  model TodoList, :find

  def process(params)
    model.destroy
  end
end

class TodoList::GetOrCreateDefaultTodoList < Trailblazer::Operation
  contract do
    property :user_id
  end

  def process(params)
    self.model = TodoList.where(user_id: params[:user_id]).first ||
      TodoList::Create.({ todo_list: {user_id: params[:user_id], name: 'Default Todo List'}}).model

    return model
  end
end
