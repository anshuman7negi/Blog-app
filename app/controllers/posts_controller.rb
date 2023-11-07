class PostsController < ApplicationController
  def index
     @user = User.find(params[:user_id])
     @posts = @user.posts.includes(:comments)
  end

  def show
    @post = Post.find(params[:id])
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
