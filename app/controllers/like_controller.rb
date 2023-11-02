class LikeController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
    @like = Like.new(user: @user, post: @post)
    @like.save
    redirect_to user_post_path(user_id: @user.id, id: @post.id)
  end
end
