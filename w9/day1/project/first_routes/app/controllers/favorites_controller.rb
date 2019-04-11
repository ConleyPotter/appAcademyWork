class FavoritesController < ApplicationController
  def create 
    favorite = Favorite.new(valid_params)
    if favorite.save
      render json: favorite
    else
      render json: favorite.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    favorite = Favorite.find(params[:id])
    favorite.destroy
    render json: favorite
  end

  def users_favorites
    user_id = valid_params[:user_id]
    user = User.find(user_id)

    render json: user.favorited_artworks
  end

  def artworks_favoriters
    artwork_id = valid_params[:artwork_id]
    artwork = Artwork.find(artwork_id)

    render json: artwork.people_who_have_favorited
  end

  private
  def valid_params
    params.require(:favorite).permit(:user_id, :artwork_id)
  end
end