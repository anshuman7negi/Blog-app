class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @user = current_user
    @like = Like.new(user: @user, post: @post)
    @like.save
    redirect_to user_post_path(user_id: @user.id, id: @post.id)
  end
end
