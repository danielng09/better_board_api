class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :require_signed_in!

  def current_user
    return nil if session[:oauth_token].nil?
    @current_user ||= User.find_by_oath_token(session[:oauth_token])
  end

  def signed_in?
    !!current_user
  end

  def require_signed_in!
    redirect_to login_url unless signed_in?
  end
end
