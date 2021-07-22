class UsersController < ApplicationController

  def new
  end

  def create
    @user = User.new(user_params)
    #check if email already registered. Otherwise save
    user = User.find_by_email params[:user][:email]
    if !user
      if @user.save
        session[:user_id] = @user.id
        return redirect_to [:root]
      else
        return redirect_to new_user_path
      end
    end
    redirect_to new_user_path
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
