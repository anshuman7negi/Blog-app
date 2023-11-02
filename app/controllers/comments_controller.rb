class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    @post = Post.find(params[:post_id])
    @user = current_user
    @comment = Comment.new(user: @user, post: @post, text: params[:comment][:text])
    @comment.save
    redirect_to user_post_path(user_id: @user.id, id: @post.id)
  end
end
