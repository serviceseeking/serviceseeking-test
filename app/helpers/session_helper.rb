module SessionHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    return nil if session[:user_id].nil?
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_user_or_guest
    @current_user_or_guest ||= (User.where(id: session[:user_id].to_i).first || User.where(username: "guest").first)
  end
end
