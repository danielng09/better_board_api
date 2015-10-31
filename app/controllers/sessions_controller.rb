class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:oauth_token] = user.oauth_token
    redirect_to root_path
  end

  def destroy
    session[:oauth_token] = nil
    redirect_to root_path
  end
end
