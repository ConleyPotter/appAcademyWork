class UsersController < ApplicationController
  def new
    render :new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      ### TODO: change ###
      log_in_user!(@user)
      render plain: "You've logged in!"
    else
      flash.now[:errors] ='Error creating user'
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end 