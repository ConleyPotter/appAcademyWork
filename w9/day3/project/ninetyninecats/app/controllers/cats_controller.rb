class CatsController < ApplicationController
  def index 
    cats = Cats.all
    render json: cats
  end
end