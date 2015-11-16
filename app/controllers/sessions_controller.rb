class SessionsController < ApplicationController
  def create
    user_params = User.validate_id_token(params[:id_token])
    user = User.find_or_create(user_params)
    render json: user
  end

  def destroy
    session[:oauth_token] = nil
    redirect_to root_path
  end
end
