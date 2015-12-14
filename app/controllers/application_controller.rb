class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :require_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !current_user
      flash[:error] = "You must be logged in for this page"
      redirect_to root_path
    end    
  end

  def require_same_user
    if current_user != @user
      flash[:error] = "you can't do that"
      redirect_to root_path
    end
  end
end
