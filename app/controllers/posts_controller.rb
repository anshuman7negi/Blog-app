class PostsController < ApplicationController
  def index
    @posts = Post.where(author_id: params[:user_id])
  end

  def show
    Post.includes(:comments).find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params.require(:post).permit(:title, :text))
    @post.author = current_user
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.save
      flash[:notice] = 'Your post was created successfully'
      redirect_to user_posts_url
    else
      flash.alert = 'sorry, something went wrong!'
      render :new
    end
  end
end
