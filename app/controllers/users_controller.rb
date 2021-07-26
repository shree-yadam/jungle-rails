class UsersController < ApplicationController

  def new
  end

  def create
    @user = User.new(user_params)
    @user.email = @user.email.downcase
    if @user.save
        session[:user_id] = @user.id
        return redirect_to [:root]
    end
    flash.alert = @user.errors.full_messages.first
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
