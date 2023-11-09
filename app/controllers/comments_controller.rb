class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    @post = Post.find(params[:post_id])
    @user = current_user
    @comment = Comment.new(user: @user, post: @post, text: params[:comment][:text])
    if @comment.save
      flash[:notice] = 'Comment was successfully created.'
      redirect_to user_post_path(user_id: @user.id, id: @post.id)
    else
      flash[:error] = 'Error creating the comment.'
      render 'new'
    end
  end
end
