class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(request.env["omniauth.auth"])

    session[:user_id] = user.id
    flash[:notice] = 'Login sucess'
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash[:alert] = 'See you soon'
    redirect_to root_path
  end
end
