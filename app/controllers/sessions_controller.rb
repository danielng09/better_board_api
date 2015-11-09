class SessionsController < ApplicationController
  def create
    ksf;lksdfs
    user = User.from_omniauth(env["omniauth.auth"])
    session[:oauth_token] = user.oauth_token
    render json: current_user
  end

  def destroy
    session[:oauth_token] = nil
    redirect_to root_path
  end
end
