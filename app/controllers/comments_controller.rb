class CommentsController < ApplicationController
  before_action :set_post
  
  def new
    @comment = @post.comments.new
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id 
    if @comment.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def destroy 
    @post.comments.find(params[:id]).destroy
    redirect_to post_path(@post)
  end

  private

  def set_post
    @post ||= Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end