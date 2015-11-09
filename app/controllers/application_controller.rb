class ApplicationController < ActionController::API
  helper_method :current_user

  def current_user
    return nil if session[:oauth_token].nil?
    @current_user ||= User.find_by_oath_token(session[:oauth_token])
  end

end
