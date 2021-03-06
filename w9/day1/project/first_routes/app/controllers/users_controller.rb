class UsersController < ApplicationController
  def index
    if valid_params.include?(:username)
      users = User.find_by_search(valid_params[:username])
    else
      users = User.all
    end

    render json: users
  end

  def show
    user = User.find(params[:id])
    if user
      render json: user
    else
      render json user.errors.full_messages
    end
  end

  def create
    user = User.new(valid_params)
    if user.save
      render json: user
    else
      render json: user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    user = User.find(params[:id])
    if user.update(valid_params)
      render json: user
    else
      render json: user.error.full_messages
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: user
  end

  private
  def valid_params
    params.require(:user).permit(:username)
  end
end