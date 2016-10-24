class ApplicationController < ActionController::Base
  include Trailblazer::Operation::Controller
  protect_from_forgery with: :exception

  def tyrant
    Tyrant::Session.new(request.env['warden'])
  end
  helper_method :tyrant
end
