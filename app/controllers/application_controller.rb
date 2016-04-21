class ApplicationController < ActionController::Base
  include Trailblazer::Operation::Controller
  protect_from_forgery with: :exception
  before_filter :set_temp_session_id
  include SessionHelper

  def set_temp_session_id
    session[:current_user_id] = 3
  end
end
