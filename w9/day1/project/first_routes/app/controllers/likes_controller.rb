class LikesController < ApplicationController
  def create
    like = Like.new(valid_params)
    if like.save
      render json: like
    else
      render json: like.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy 
    like = Like.find(params[:id])
    like.destroy
    render json: like
  end

  def index
    to_render = []
    if valid_params[:likeable_id]
      type = valid_params[:likeable_type].capitalize.constantize
      likeable = type.find(valid_params[:likeable_id])
      to_render += likeable.people_who_have_liked || []
    else
      user = User.find(valid_params[:user_id])
      to_render += user.liked_artworks || []
      to_render += user.liked_comments || []
    end

    render json: to_render
  end

  private
  def valid_params
    params.require(:like).permit(:user_id, :likeable_id, :likeable_type)
  end
end