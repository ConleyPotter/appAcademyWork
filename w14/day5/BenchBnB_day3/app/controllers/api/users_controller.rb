class Api::UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      render :show
    else
      # flash.now[:errors] = ["Invalid Username or password"]
      render json: { errors: { error_code: 422, message: "Invalid credentials" } }
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
