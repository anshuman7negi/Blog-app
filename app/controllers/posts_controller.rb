class PostsController < ApplicationController
  load_and_authorize_resource
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
    @post = Post.new(post_params)
    @post.author = User.find(params[:user_id])
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

  def destroy
    @user = User.find(params[:user_id])
    post = Post.find(params[:id])
    authorize! :destroy, post

    post.comments.destroy_all
    post.likes.destroy_all
    if post.destroy
      flash[:success] = 'Post deleted successfully'
      redirect_to user_posts_path(@user)
    else
      flash.now[:error] = 'Error: Post could not be deleted'
      redirect_to user_post_path(@user, post)
    end
  end

  private

def post_params
  params.require(:post).permit(:title, :text)
end


end
