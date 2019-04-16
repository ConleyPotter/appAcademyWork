class ApplicationController < ActionController::Base
  helper_method :current_user, :login, :logged_in?
  
  def log_in_user!(user)
    self.session[:session_token] = user.reset_session_token!
  end

  def current_user
    @user = User.find_by(session_token: session[:session_token])
  end

  def logout
    current_user.reset_session_token!
    current_user.session_token = nil
    session[:session_token] = nil
  end

  def logged_in?
    !!current_user
  end

  def ensure_logged_in
    redirect_to new_session_url unless logged_in?
  end
end
