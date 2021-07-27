class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.authenticate_with_credentials(params[:session][:email], params[:session][:password])
    if @user
      # If user authenticated then set session id to create logged in status
      session[:user_id] = @user.id
      redirect_to [:root]
    else
      # Display failure message in case of authentication failure
      flash.alert = "Invalid email or password!"
      redirect_to new_session_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to [:root]
  end

end
