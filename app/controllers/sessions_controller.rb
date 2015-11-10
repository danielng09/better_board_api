class SessionsController < ApplicationController
  def create
    user = User.find_or_create(user_params)
    render json: user
  end

  def destroy
    session[:oauth_token] = nil
    redirect_to root_path
  end

  private
  def user_params
   params.require(:user).permit(:pid, :name, :email, :imageUrl)
 end
end
