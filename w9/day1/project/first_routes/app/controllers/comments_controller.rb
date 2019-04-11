class CommentsController < ApplicationController
  def create
    comment = Comment.new(valid_params)
    if comment.save
      render json: comment
    else
      render json: comment.errors.full_messages
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    render json: comment
  end

  def index
    to_render = []
    if valid_params[:user_id]
      user = User.find(valid_params[:user_id])
      to_render += user.comments
    end

    if valid_params[:artwork_id]
      artwork = Artwork.find(valid_params[:artwork_id])
      to_render += artwork.comments
    end
    

    render json: to_render
  end

  private
  def valid_params
    params.require(:comment).permit(:body, :user_id, :artwork_id)
  end
end