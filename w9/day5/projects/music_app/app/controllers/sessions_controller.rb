class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
    if @user
      log_in_user!(@user)
      render plain: "Welcome back #{@user.email}!"
      # redirect_to :show
    else
      flash[:errors] = 'Error creating session'
      render :new
    end
  end
end