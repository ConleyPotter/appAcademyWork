class PostsController < ApplicationController 
  def index
    #find sub first via the wildcard params[sub_id]
    sub = Sub.find(params[:sub_id])
    @posts = sub.posts.all 
    if @posts 
      render :index
    else 
      render :new 
    end
  end 

  def new 
    render :new 
  end 

  def create 
    @post = Post.new(title: params[:post][:title],
                    url: params[:post][:url],
                    content: params[:post][:content])
    
    post_subs = params[:post][:sub_id]
    post_subs.each do |post_sub|
      PostSub.create(sub_id: post_sub, post_id: @post.id)
    end

    if @post.save 
      redirect_to sub_posts_url(@post)
    else
      render :new 
    end
  end

  def update
    @post = current_user.posts.find_by(post_params)
    if @post.save 
      redirect_to sub_posts_url
    else
      render :edit 
    end
  end 

  def destroy
    @post = Post.find_by(post_params)
    if @post.destroy 
      redirect_to sub_posts_url
    else 
      render :show 
    end
  end 

  def edit 
    @post = current_user.posts.find_by(post_params)
    if @post
      render :edit 
    else
      redirect_to subs_url 
    end
  end 

  def show
    @post = Post.find(params[:id])
  end 

  private 
  def post_params 
    params.require(:post).permit(:title, :url, :content, sub_id:[])
  end
end