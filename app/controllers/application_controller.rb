class ApplicationController < ActionController::Base
  include Trailblazer::Operation::Controller
  protect_from_forgery with: :exception
end
