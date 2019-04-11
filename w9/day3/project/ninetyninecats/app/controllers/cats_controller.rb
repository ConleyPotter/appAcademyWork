class CatsController < ApplicationController
  def index 
    @cats = Cat.all
    render :index
  end

  def show 
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    cat = Cat.new(cat_params)
    if cat.save
      redirect_to :cats
    else
      render json: cat.errors.full_messages, status: :unprocessable_entity
    end
  end

  def edit 
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      render :show
    else
      render json: @cat.errors.full_messages
    end
  end

  private
  def cat_params
    params.require(:cat).permit(:name, :birthdate, :color, :sex, :description)
  end
end