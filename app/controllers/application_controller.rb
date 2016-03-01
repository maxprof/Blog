class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
  	!!current_user
  end

  def require_user
  	if !logged_in?
  		flash[:warning] = "You should login for the opening all opportunities of the site"
  		redirect_to articles_path
  	end
  end
end
