class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @comments = Comment.includes(:user).order(created_at: :desc)
    @comment = Comment.new
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build(comment_params)
    if @comment.save
      redirect_to comments_path
    else
      render :new
    end
  end

  def destroy
    @comment = current_user.comments.find(params[:id])
    @comment.destroy
    redirect_to comments_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
