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

  def destroy
    @comment = Comment.find(params[:id])
    user = @comment.user_id
    post = @comment.post_id
    if @comment.destroy
      flash[:success] = 'Comment deleted successfully'
    else
      flash[:error] = 'Error: Comment could not be deleted'
    end
    redirect_to user_post_path(user, post)
  end
end
