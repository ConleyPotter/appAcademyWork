class SubsController < ApplicationController 
  before_action :is_moderator, only: [:edit, :update]
  def new
    @moderator = current_user
    render :new
  end
  
  def create
    @sub = Sub.new(sub_params)
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end
  
  def edit
    @sub = Sub.find(params[:id])
    @moderator = @sub.moderator
    render :edit
  end

  def show
    @sub = Sub.find(params[:id])
    @posts = @sub.posts
    render :show  
  end

  def index
    @all_subs = Sub.all
    render :index
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.save
      redirect_to sub_posts_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      redirect_to :edit
    end
  end

  def destroy
    @sub = Sub.find(params[:id])
    @sub.destroy
    render :index
  end

  def is_moderator
    sub = Sub.find(params[:id])
    current_user == sub.moderator
  end
  private

  def sub_params
    params.require(:sub).permit(:title, :description, :moderator_id)
  end
end