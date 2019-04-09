class ArtworksController < ApplicationController
  def index
    render json: Artwork.all
  end

  def show
    artwork = Artwork.find(params[:id])
    if artwork
      render json: artwork
    else
      render json artwork.errors.full_messages
    end
  end

  def create
    artwork = Artwork.new(valid_params)
    if artwork.save
      render json: artwork
    else
      render json: artwork.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    artwork = Artwork.find(params[:id])
    if artwork.update(valid_params)
      render json: artwork
    else
      render json: artwork.error.full_messages
    end
  end

  def destroy
    artwork = Artwork.find(params[:id])
    artwork.destroy
    render json: artwork
  end

  private
  def valid_params
    params.require(:artwork).permit(:title, :artist_id, :image_url)
  end
end
