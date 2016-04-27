class User::Create < Trailblazer::Operation
  include Model
  model User, :create

  contract do
    property :fullname
  end

  def process(params)
    validate(params[:user]) do
      contract.save
    end
  end

  def self.get_user(params)
    return params[:current_user] if params[:current_user].present?
   
    if params[:current_user_id].nil?
      result, operation = User::Create.run(user: {})
      operation.model
    else
      User.find(params[:current_user_id])
    end
  end

  private

    def setup_model!(params)
      model.fullname = User::DEFAULT_FULLNAME unless model.fullname.present?
    end
end