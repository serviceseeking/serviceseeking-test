class SessionsController < ApplicationController
 before_filter( only: [:sign_in, :sign_up]) { redirect_to todo_lists_path if tyrant.signed_in? }

  def sign_up
  	form Session::SignUp
  end

  def signing_up
    run Session::SignUp do |op|
      flash[:notice] = "Please log in now!"
      return redirect_to sessions_sign_in_path 
    end

    render action: :sign_up
  end

  def sign_in
    form Session::SignIn
  end

  def signing_in
    run Session::SignIn do |op| 
      tyrant.sign_in!(op.model)
      flash[:notice] = "Welcome!"
      return redirect_to todo_lists_path
    end
    flash[:alert] = "Invalid username/password"
    render action: :sign_in
  end

  def sign_out
    run Session::SignOut do
      tyrant.sign_out!
      flash[:notice] = "Logged out"
      redirect_to sessions_sign_in_path 
    end
  end

end
