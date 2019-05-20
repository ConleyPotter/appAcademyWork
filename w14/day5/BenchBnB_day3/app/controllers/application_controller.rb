class ApplicationController < ActionController::Base
  # skip_before_action :verify_authenticity_token
  protect_from_forgery with: :null_session

  helper_method :logged_in?, :current_user
  # LLLEC

  def login(user)
    session[:session_token] = user.reset_session_token!
    @current_user = user
  end

  def logout
    current_user.try(:reset_session_token!)
    # current_user.reset_session_token!
    @current_user = nil
    session[:session_token] = nil
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def ensure_logged_in
    redirect_to new_session_url unless logged_in?
  end
end
