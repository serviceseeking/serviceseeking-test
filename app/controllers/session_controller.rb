class SessionController < ApplicationController
  def sign_up
    form Session::Create
  end

  def sign_in
    render :login
  end

  def create_user
    run Session::Create do |user|
      log_in(@model)
      return redirect_to todo_lists_path, notice: "Your account has been created!"
    end

    render :sign_up
  end

  def log_out
    session[:user_id] = nil
    redirect_to root_path
  end

  def sign_in
    form Session::Login
  end

  def authenticate
    run Session::Login do
      log_in(@model)
      return redirect_to todo_lists_path, notice: "Successfully Authenticated"
    end

    render :sign_in
  end
end
