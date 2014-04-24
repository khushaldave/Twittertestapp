class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    flash[:notice] = "You have successfully logged In"
    redirect_to root_path
  end
 
  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have successfully logged Out"
    redirect_to root_path
  end
end